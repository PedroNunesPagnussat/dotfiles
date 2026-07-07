#!/usr/bin/env python3
"""harness-scan: mine the last N days of Claude Code transcripts into a compact
friction+leverage digest. Deterministic stage-1 extractor; a model reasons over
the output (the `period` branch of the harness-check skill).

Reads ~/.claude/projects/**/*.jsonl (read-only). Emits markdown to stdout.
  FRICTION  — observed pain to remove (errors, rejections, corrections, perms)
  LEVERAGE  — repeated manual effort / gaps to pave into the harness

Structure: extraction (parse_session → SessionMeta, aggregated into ScanResult)
is kept separate from rendering (render → markdown). The two stages share no
state beyond the ScanResult handed between them.
"""
from __future__ import annotations

import argparse
import glob
import json
import os
import re
import time
from collections import Counter, defaultdict
from dataclasses import dataclass, field

ROOT = os.path.expanduser("~/.claude/projects")
HOME = os.path.expanduser("~")
SKILLS_DIR = os.path.expanduser("~/.claude/skills")


# ---------- text helpers ----------

def iter_events(path):
    """Yield each JSON event from a transcript, skipping blank/corrupt lines."""
    with open(path) as fh:
        for line in fh:
            line = line.strip()
            if line:
                try:
                    yield json.loads(line)
                except Exception:
                    pass


def abbreviate_home(path):
    """Collapse the home prefix to ~ for compact, stable paths."""
    return path.replace(HOME, "~") if isinstance(path, str) else path


def normalize_perm_target(target):
    """Reduce a permission target to a groupable key (a path's dir + /*)."""
    target = target.strip().strip("'\"")
    if target.startswith("/") or target.startswith("~"):
        target = abbreviate_home(target)
        parent = os.path.dirname(target)
        return parent + "/*" if parent else target
    return target[:60]


GENERIC_COMMANDS = {"ls", "cd", "echo", "cat", "pwd", "grep", "rg", "find", "wc", "head", "tail",
    "sed", "awk", "mkdir", "rm", "cp", "mv", "chmod", "chown", "touch", "for", "while", "if",
    "set", "command", "readlink", "which", "test", "true", "false", "export", "source",
    "env", "sort", "uniq", "tr", "cut", "xargs", "basename", "dirname", "printf", "tee",
    "cmp", "diff", "ln", "stat", "du", "df", "kill", "sleep", "clear", "type", "realpath"}


def is_generic(shape):
    """True when a Bash shape's verb is a plain builtin, so it carries no signal."""
    return shape.split()[0] in GENERIC_COMMANDS


def bash_shape(command):
    """Collapse a Bash command to its verb(+subcommand) so repeats group."""
    if not isinstance(command, str):
        return None
    first_segment = re.split(r"[|;\n]|&&|\|\|", command.strip(), maxsplit=1)[0].strip()
    tokens = first_segment.split()
    while tokens and re.match(r"^\w+=", tokens[0]):   # drop VAR=val prefixes
        tokens = tokens[1:]
    if not tokens:
        return None
    verb = os.path.basename(tokens[0])
    if len(tokens) > 1 and re.match(r"^[a-z][a-z0-9-]+$", tokens[1]):
        return f"{verb} {tokens[1]}"[:40]
    return verb[:40]


CORRECTIVE = re.compile(
    r"^\s*(no[,.\s]|nope|don'?t|do not|stop|actually|wait[,.\s]|that'?s wrong|"
    r"wrong[,.\s]|not that|instead|i said|i asked|why did you|you (?:didn'?t|shouldn'?t|were)|"
    r"revert|undo|that'?s not|no need)", re.I)
CMD_RE = re.compile(r"<command-name>\s*/?([\w:-]+)\s*</command-name>")
PERM_RE = re.compile(r"requested permissions to (.+?),?\s*but you haven'?t granted", re.I)
REJECT_RE = re.compile(r"tool use was rejected|user doesn'?t want to proceed|user has chosen not to", re.I)


def classify_error(text):
    """Bucket a tool_result error into a short, groupable kind."""
    t = text.lower()
    if "haven't granted" in t or "haven’t granted" in t: return "permission-not-granted"
    if REJECT_RE.search(t): return "user-rejected"
    if "modified since read" in t: return "stale-read"
    if "no such file" in t or "cannot access" in t or "does not exist" in t: return "path-not-found"
    if "command not found" in t or "not found in $path" in t: return "missing-command"
    if "timed out" in t or "timeout" in t: return "timeout"
    m = re.search(r"exit code (\d+)", t)
    if m: return f"exit-{m.group(1)}"
    if "permission denied" in t: return "os-permission-denied"
    return "other"


def human_message(event):
    """Return the text of a genuine typed human turn, or None for machinery
    (command wrappers, tool results, system reminders, oversized pastes)."""
    if event.get("type") != "user":
        return None
    content = event.get("message", {}).get("content")
    if not isinstance(content, str):
        return None
    text = content.strip()
    if not text or len(text) > 2000:
        return None
    if text.startswith("<") and "command" in text[:40]:
        return None
    if "local-command-caveat" in text or "system-reminder" in text[:60]:
        return None
    return text


def installed_skills():
    """Names of every installed skill and slash command, for adoption checks."""
    names = {os.path.basename(os.path.dirname(p))
             for p in glob.glob(os.path.join(SKILLS_DIR, "*", "SKILL.md"))}
    for p in glob.glob(os.path.join(SKILLS_DIR, "..", "commands", "*.md")):
        names.add(os.path.splitext(os.path.basename(p))[0])
    return names


# ---------- extraction ----------

@dataclass
class SessionMeta:
    """Per-session facts. Automated jobs (no human turn) are tagged so their
    'corrections' can be discounted while their permission walls still count."""
    title: str | None = None
    cwd: Counter = field(default_factory=Counter)
    assistant_turns: int = 0
    human_turns: int = 0
    duration_ms: int = 0
    perm_modes: list = field(default_factory=list)      # mode changes, deduped consecutively
    perm_keys: list = field(default_factory=list)       # 'not granted' targets, in encounter order
    top_shape: tuple | None = None                      # this session's dominant Bash shape

    @property
    def automated(self):
        return self.human_turns == 0

    def label(self):
        return self.title or (self.cwd.most_common(1)[0][0] if self.cwd else "?")


@dataclass
class ScanResult:
    """Everything render needs: the sessions plus the cross-session aggregates.
    Counters are filled in file order so most_common ties stay deterministic."""
    days: int
    files: list = field(default_factory=list)
    sessions: dict = field(default_factory=dict)

    # friction aggregates
    perm_needed: Counter = field(default_factory=Counter)
    perm_needed_auto: Counter = field(default_factory=Counter)
    err_clusters: Counter = field(default_factory=Counter)
    err_samples: defaultdict = field(default_factory=lambda: defaultdict(list))
    rejections: Counter = field(default_factory=Counter)
    corrective: list = field(default_factory=list)

    # leverage aggregates
    slash: Counter = field(default_factory=Counter)
    skill_calls: Counter = field(default_factory=Counter)
    shape_count: Counter = field(default_factory=Counter)
    shape_sessions: defaultdict = field(default_factory=lambda: defaultdict(set))
    bigram_count: Counter = field(default_factory=Counter)
    bigram_sessions: defaultdict = field(default_factory=lambda: defaultdict(set))
    file_sessions: defaultdict = field(default_factory=lambda: defaultdict(set))

    # derived after every session is parsed
    human_msgs: list = field(default_factory=list)      # (path, normalized text) for repeat detection
    repeats: dict = field(default_factory=dict)
    dead: list = field(default_factory=list)


def recent_session_files(days):
    """Transcripts touched within the window, oldest first."""
    cutoff = time.time() - days * 86400
    paths = (p for p in glob.glob(os.path.join(ROOT, "**", "*.jsonl"), recursive=True)
             if os.path.getmtime(p) > cutoff)
    return sorted(paths, key=os.path.getmtime)


def record_assistant_tools(event, path, result, last_tool, shapes, shape_local):
    """Fold an assistant turn's tool calls into the leverage aggregates."""
    for block in event.get("message", {}).get("content", []) or []:
        if not (isinstance(block, dict) and block.get("type") == "tool_use"):
            continue
        name = block.get("name", "?")
        inp = block.get("input", {}) or {}
        last_tool[block.get("id")] = name
        if name == "Skill":
            result.skill_calls[str(inp.get("skill", "?"))] += 1
        elif name == "Bash":
            shape = bash_shape(inp.get("command"))
            if shape:
                result.shape_count[shape] += 1
                result.shape_sessions[shape].add(path)
                shape_local[shape] += 1
                shapes.append(shape)
        elif name in ("Read", "Edit", "Write"):
            file_path = inp.get("file_path")
            if file_path:
                result.file_sessions[abbreviate_home(file_path)].add(path)


def record_tool_error(block, path, meta, result, last_tool):
    """Route one errored tool_result to permission / rejection / error-cluster."""
    raw = block.get("content")
    text = raw if isinstance(raw, str) else json.dumps(raw)
    kind = classify_error(text)
    tool = last_tool.get(block.get("tool_use_id"), "?")
    if kind == "permission-not-granted":
        match = PERM_RE.search(text)
        meta.perm_keys.append(normalize_perm_target(match.group(1)) if match else "?")
    elif kind == "user-rejected":
        result.rejections[path] += 1
    else:
        result.err_clusters[(tool, kind)] += 1
        if len(result.err_samples[(tool, kind)]) < 2:
            result.err_samples[(tool, kind)].append(text[:120].replace("\n", " "))


def record_user_turn(event, path, meta, result, last_tool):
    """Fold a user turn: human text (slash/corrective/repeat) and tool errors."""
    human = human_message(event)
    if human is not None:
        meta.human_turns += 1
        for m in CMD_RE.finditer(human):
            result.slash[m.group(1)] += 1
        if CORRECTIVE.match(human):
            result.corrective.append((path, human[:200]))
        result.human_msgs.append((path, re.sub(r"\s+", " ", human.lower()).strip()))

    content = event.get("message", {}).get("content")
    if isinstance(content, str):
        for m in CMD_RE.finditer(content):
            result.slash[m.group(1)] += 1
    elif isinstance(content, list):
        for block in content:
            if isinstance(block, dict) and block.get("type") == "tool_result" and block.get("is_error"):
                record_tool_error(block, path, meta, result, last_tool)


def parse_session(path, result):
    """Read one transcript into a SessionMeta, folding cross-session aggregates
    into `result` as it goes."""
    meta = SessionMeta()
    last_tool = {}              # tool_use id -> tool name, to attribute later errors
    shapes = []                 # Bash shapes in encounter order (for ritual bigrams)
    shape_local = Counter()     # this session's shape frequencies (for top_shape)

    for event in iter_events(path):
        event_type = event.get("type")
        if event.get("cwd"):
            meta.cwd[abbreviate_home(event["cwd"])] += 1

        if event_type == "ai-title":
            meta.title = event.get("aiTitle")
        elif event_type == "permission-mode":
            mode = event.get("permissionMode")
            if not meta.perm_modes or meta.perm_modes[-1] != mode:
                meta.perm_modes.append(mode)
        elif event_type == "assistant":
            meta.assistant_turns += 1
            record_assistant_tools(event, path, result, last_tool, shapes, shape_local)
        elif event_type == "system":
            if event.get("subtype") == "turn_duration":
                meta.duration_ms += event.get("durationMs", 0)
        elif event_type == "user":
            record_user_turn(event, path, meta, result, last_tool)

    # rituals: consecutive distinct shapes within this session
    for first, second in zip(shapes, shapes[1:]):
        if first != second:
            result.bigram_count[(first, second)] += 1
            result.bigram_sessions[(first, second)].add(path)
    if shape_local:
        meta.top_shape = shape_local.most_common(1)[0]
    for key in meta.perm_keys:
        target = result.perm_needed_auto if meta.automated else result.perm_needed
        target[key] += 1
    return meta


def repeated_openings(human_msgs):
    """First-8-words openings that recur across 2+ sessions (recurring request)."""
    openings = defaultdict(set)
    for path, normalized in human_msgs:
        words = normalized.split()
        if len(words) >= 3:
            openings[" ".join(words[:8])].add(path)
    return {opening: len(paths) for opening, paths in openings.items() if len(paths) >= 2}


def dead_skills(slash, skill_calls):
    """Installed skills that never fired in the window."""
    fired = set(slash) | set(skill_calls)
    return sorted(installed_skills() - fired)


def scan(days):
    result = ScanResult(days=days, files=recent_session_files(days))
    for path in result.files:
        result.sessions[path] = parse_session(path, result)
    result.repeats = repeated_openings(result.human_msgs)
    result.dead = dead_skills(result.slash, result.skill_calls)
    return result


# ---------- rendering ----------

def render(result):
    sessions = result.sessions
    interactive = {p: m for p, m in sessions.items() if not m.automated}
    automated = {p: m for p, m in sessions.items() if m.automated}
    lines = []
    emit = lines.append

    emit(f"# Harness digest — last {result.days} days")
    emit(f"\n{len(result.files)} sessions · {len(interactive)} interactive · {len(automated)} automated. "
         "Each finding below must anchor to real recurrence; the gate is 2+ occurrences.\n")
    by_project = Counter()
    for meta in interactive.values():
        if meta.cwd:
            by_project[meta.cwd.most_common(1)[0][0]] += 1
    emit("Interactive sessions by project: " + ", ".join(f"{n}×{p}" for p, n in by_project.most_common(8)))

    emit("\n# FRICTION  (observed pain → remove)")
    emit("\n## F1 Permission friction")
    escalated = [(m.label(), m.perm_modes) for m in interactive.values()
                 if any(mode in ("acceptEdits", "bypassPermissions") for mode in m.perm_modes)]
    emit(f"Escalated past default: {len(escalated)} sessions" +
         ("".join(f"\n- {name}: {' → '.join(modes)}" for name, modes in escalated[:6]) if escalated else ""))
    emit("'Not granted' — interactive (allowlist candidates): " +
         (", ".join(f"{n}× {k}" for k, n in result.perm_needed.most_common(10)) or "none"))
    emit("'Not granted' — automated jobs (grant to the job): " +
         (", ".join(f"{n}× {k}" for k, n in result.perm_needed_auto.most_common(6)) or "none"))

    emit("\n## F2 Tool errors (excl. permission + rejection)")
    for (tool, kind), n in result.err_clusters.most_common(14):
        samples = result.err_samples.get((tool, kind), [])
        emit(f"- {n}× {tool}/{kind}" + (f"  e.g. {samples[0]}" if samples else ""))
    if not result.err_clusters:
        emit("- none")

    emit("\n## F3 User rejections (tool declined)")
    emit(f"{sum(result.rejections.values())} across {len(result.rejections)} sessions: " +
         ", ".join(f"{n}×{sessions[p].label()}" for p, n in result.rejections.most_common(8)))

    emit("\n## F4 Corrective user turns (CLAUDE.md rule candidates)")
    for path, text in result.corrective[:12]:
        emit(f"- [{sessions[path].label()}] {text}")
    if not result.corrective:
        emit("- none")

    emit("\n# LEVERAGE  (repeated manual effort → pave)")
    emit("\n## L1 Repeated Bash shapes (skill/alias/hook candidates; generic builtins omitted)")
    shapes = sorted(((s, n) for s, n in result.shape_count.items() if not is_generic(s)),
                    key=lambda kv: (-len(result.shape_sessions[kv[0]]), -kv[1]))
    for shape, n in shapes[:12]:
        emit(f"- {n}× across {len(result.shape_sessions[shape])} sessions: `{shape}`")
    if not shapes:
        emit("- none")

    emit("\n## L2 Recurring command rituals (bigrams in ≥2 sessions; both-generic omitted)")
    rituals = sorted(((pair, n) for pair, n in result.bigram_count.items()
                      if len(result.bigram_sessions[pair]) >= 2 and not (is_generic(pair[0]) and is_generic(pair[1]))),
                     key=lambda kv: (-len(result.bigram_sessions[kv[0]]), -kv[1]))
    for (first, second), n in rituals[:10]:
        emit(f"- {len(result.bigram_sessions[(first, second)])} sessions: `{first}` → `{second}`")
    if not rituals:
        emit("- none")

    emit("\n## L3 Cross-session file hotspots (≥3 sessions → CLAUDE.md/pointer)")
    hotspots = sorted(((p, len(s)) for p, s in result.file_sessions.items() if len(s) >= 3),
                      key=lambda x: -x[1])
    for path, n in hotspots[:12]:
        emit(f"- {n} sessions: {path}")
    if not hotspots:
        emit("- none")

    emit("\n## L4 Skill adoption")
    emit("Dead skills (installed, never fired this window): " + (", ".join(result.dead) or "none"))
    emit("Fired — slash: " + ", ".join(f"{n}×/{k}" for k, n in result.slash.most_common(12)))
    emit("Fired — model-invoked Skill: " + (", ".join(f"{n}×{k}" for k, n in result.skill_calls.most_common(10)) or "none"))

    emit("\n## L5 Repetitive high-turn sessions (automation candidates)")
    for meta in sorted(interactive.values(), key=lambda m: -m.assistant_turns)[:8]:
        top = meta.top_shape
        dominant = f" · top `{top[0]}`×{top[1]}" if top else ""
        emit(f"- {meta.assistant_turns} turns · {meta.duration_ms // 1000}s{dominant} · {meta.label()}")

    emit("\n## L6 Repeated instructions (recurring request → skill)")
    if result.repeats:
        for opening, n in sorted(result.repeats.items(), key=lambda x: -x[1])[:8]:
            emit(f"- {n} sessions: \"{opening}…\"")
    else:
        emit("- none")
    return "\n".join(lines)


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--days", type=int, default=7)
    print(render(scan(ap.parse_args().days)))
