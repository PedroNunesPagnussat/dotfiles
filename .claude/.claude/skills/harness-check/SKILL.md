---
name: harness-check
description: Review this session, or your last N days, for harness upgrades — friction to remove and leverage to add — and propose specific fixes (a CLAUDE.md line, a permission/settings change, a hook, a skill). Proposes only.
disable-model-invocation: true
---

# Harness check

Turn real usage into concrete harness upgrades, of two kinds:
- **Friction** — the harness made you repeat yourself or re-approve. Remove it.
- **Leverage** — a workflow that ran fine by hand but would pay to pave into the harness, so it runs itself next time. Add it.

Diagnose and propose; apply nothing without a go-ahead.

Two scopes, set by the argument:
- **session** (default, no argument) — this conversation, from context plus this session's transcript.
- **period** — the last N days across every project, mined by a script. Trigger: `/harness-check period [days]` (default 7).

## 1. Recover the signal

**session scope** — Scan this conversation for both kinds:
- **Friction** — a correction or instruction you gave twice, a permission denied or re-prompted.
- **Leverage** — a multi-step task you drove by hand and would drive again, a manual check a hook could own, a tool or data source you reached for and lacked.

Read this session's transcript too (newest `.jsonl` under
`~/.claude/projects/<cwd-slug>/`), grepping for repeated Bash commands and
permission rejections — the highest-signal friction, and the easiest to miss
from memory. Skip only if the session was short and uncompacted.

**period scope** — Run the extractor and read its digest:

```
python3 ~/.claude/skills/harness-check/harness-scan.py --days 7
```

It folds every session in the window into a labelled digest (a few thousand
tokens, not the raw transcripts): `F1–F4` friction (permission walls,
tool-error clusters, rejections, corrective turns) and `L1–L6` leverage
(repeated commands, rituals, file hotspots, skill adoption, automation
candidates). Treat it as raw material, not conclusions — the noisier rungs
(generic Bash shapes, raw turn-count) only earn a finding after the gate below.
Automated/headless jobs are tagged separately; their permission walls are still
real fixes (grant the job), but their "corrections" are not.

## 2. Filter by recurrence
Keep a signal only if it happened 2+ times or will obviously recur in a future
session. Every finding — friction or leverage — must anchor to a moment that
actually happened; an improvement you only imagine wanting is a
manufactured finding, worse than none. If nothing survives, say so and stop.

## 3. Map each survivor to its mechanism
| Signal | Fix |
|---|---|
| Same permission prompt recurring | `permissions.allow` entry in settings.json |
| "Always do X when/after Y" | a hook (the harness runs it, not me) |
| Same preference/instruction repeated | a CLAUDE.md line |
| Repeated multi-step workflow | a skill or slash command |
| Missing/wrong tool or data | an MCP server, or a CLAUDE.md pointer |
| Key/shortcut friction | keybindings.json |

## 4. Present as a table, ranked by value
One row per finding, highest value first. Recommendations — a ready fix backed
by a hard 2+ count — rank at the top; speculative ideas — grounded in a real
moment but resting on "will obviously recur", or with no ready diff yet — rank
as rows below them.

| # | Lane | Signal | Fix | Where | Cost |
|---|------|--------|-----|-------|------|

- **Lane** — friction or leverage.
- **Signal** — quote the moment(s) it happened. Never a hypothetical.
- **Fix** — the exact line or permission string, ready to paste. Too big for a cell (a hook block, a skill file)? Put a short label in the cell and the full body in a fenced block below the table, keyed by `#`. For a speculative row, a one-line idea is enough — no diff required.
- **Where** — the file it lands in.
- **Cost** — what it risks or forecloses (e.g. a broad allowlist widens what runs unprompted).

Then stop. To apply, hand off: `/update-config` for settings, permissions, and
hooks; `/keybindings-help` for keys.
