---
name: hand-off
description: Produce an end-of-session handoff document that lets another Claude agent resume the current work cleanly. Use this whenever the user types "/hand-off", "/handoff", "hand off", or otherwise signals they want to dump session state for a successor agent. The output is a strictly structured markdown file optimized for another agent to parse, not a human-readable summary.
---

# Hand-off

## Purpose

The next agent has none of this session's context. Their only input is the handoff file. If a section is vague, missing, or assumed, the next agent will either redo work, ask the user redundant questions, or make a wrong decision. Treat the file as the complete state transfer.

The audience is an agent, not a human. Optimize for parseability and completeness over readability. Don't soften, don't pad, don't editorialize.

## Trigger

The user invokes this manually via `/hand-off` (or close variants: `/handoff`, "hand off", "handoff please"). Do not invoke automatically.

## Workflow

1. Review the full conversation from the start. Extract state from what actually happened, not what was planned.
2. Infer aggressively. If something is unclear, mark it `[UNCERTAIN: <what's unclear and why>]` inline rather than asking the user. The point of `/hand-off` is one shot, not an interview.
3. Write the file to `/mnt/user-data/outputs/handoff-YYYY-MM-DD-HHMM.md` using the user's local time. If user-local time is unknown, use UTC and note `UTC` in the timestamp like `handoff-2026-05-15-1430-UTC.md`.
4. Call `present_files` on the resulting path. Do not paste the contents into chat. The deliverable is the file.
5. Keep your chat reply minimal: one sentence confirming the file was written, nothing else.

## Output format

Use this exact template. Section order is fixed. Section headers are fixed. Do not add, rename, or reorder sections. If a section has no content, write `None.` rather than omitting it, so the next agent can confirm nothing was missed.

```markdown
# Handoff: <one-line task description>

**Session date:** <YYYY-MM-DD HH:MM timezone>
**Handoff written by:** Claude (model: <model name if known, else "unknown">)

## Goal

<The ultimate objective the user is trying to accomplish. Not the immediate task, the underlying goal. One to three sentences.>

## Current state

<Concrete description of where things stand right now. What exists, what's been decided, what's running. No vibes, no "we explored X". State facts the next agent can act on.>

## What's been done

<Chronological or thematic list of the key actions taken and decisions made this session. Skip exploratory dead-ends unless they constrain future choices. Each item is one line.>

- <item>
- <item>

## What's next

<The immediate next action the agent should take, followed by the queued actions after that. Be specific enough that the next agent doesn't need to re-plan.>

1. <immediate next step>
2. <next>
3. <next>

## Open questions and blockers

<Things that require user input or external resolution before the agent can proceed. If none, write "None.">

- <question or blocker>

## Key context

<Anything the next agent won't infer from the file structure alone: constraints, user preferences specific to this task, gotchas, things that were tried and rejected, domain assumptions. Bias toward including borderline items.>

- <item>

## Conventions established

<Naming choices, tool/library choices, style decisions, file layout, or any other convention agreed upon mid-session that the next agent should preserve. If none, write "None.">

- <item>
```

## Rules for content

- **Be specific.** "Working on the API" is useless. "Implementing POST /users endpoint, currently writing request validation in `handlers/users.py`" is useful.
- **Names, not pronouns.** "The user wants X" not "they want X". The next agent has no antecedent for "they" or "it".
- **Quote user preferences verbatim** when they appear. If the user said "always use tabs", write that exactly, not "the user prefers tab indentation".
- **Mark uncertainty inline.** Use `[UNCERTAIN: <reason>]` immediately after the claim. Do not have a separate "uncertain" section.
- **No filler.** Drop "Let me know if you need clarification", "Hope this helps", "I think", etc. The reader is an agent.
- **No reasoning narration.** Don't explain why you chose to include something. Just include it.

## Example

**Bad** (vague, narrated, human-toned):
```
## What's next
We were thinking about maybe refactoring the auth module next, but it might
be worth checking with the user first. There's also some cleanup to do.
```

**Good** (specific, imperative, agent-toned):
```
## What's next
1. Refactor `auth/session.py` to extract token validation into a separate function (user agreed to this in turn 14).
2. Run the test suite at `tests/auth/` and fix any failures.
3. [UNCERTAIN: whether the user wants the refactor to also cover `auth/oauth.py` — they mentioned it once but didn't confirm scope].
```

## After writing

After `present_files`, the chat reply should be a single line, e.g.:

> Handoff written to `handoff-2026-05-15-1430.md`.

Do not summarize the handoff in chat. The next agent reads the file, not the chat.