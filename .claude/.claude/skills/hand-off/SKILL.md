---
name: hand-off
description: Compact the current conversation into a handoff document for another agent to pick up.
argument-hint: What will the next session be used for?
disable-model-invocation: true
---

Produce a **briefing**: what a **cold reader** needs to act, and nothing else. No transcript, no narration of how we got here. Shape it toward the next session's purpose if an argument was given.

## Steps

1. Scan the conversation against every section of the template below. Done when each section has content or is explicitly marked N/A.

2. Write the briefing to `hand-off-<timestamp>.md` (e.g. `hand-off-2026-07-03T14-32.md`) in the current working directory. Done when a cold reader could execute Next Steps without asking a single question.

<briefing-template>

## Goal
What we're building or solving, in one or two sentences.

## Context
What this conversation learned that the repo doesn't say: constraints, gotchas, approaches already ruled out. Skip whatever the cold reader gets from CLAUDE.md or a glance at the code.

## State
- Done: ...
- In progress: ...
- Blocked: ... (if any)

Any claim you haven't re-verified this turn, mark with when it was true.

## Decisions
Key choices made and the brief rationale that closed them. Skip anything obvious.

## Next Steps
Concrete actions for the next session, ordered by priority.

## Files & Commands
Paths, branches, commands, error messages the cold reader will need. Use `file:line` or `file:function` where precision matters.

</briefing-template>
