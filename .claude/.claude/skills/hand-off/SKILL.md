---
name: hand-off
description: Compact the current conversation into a handoff document for another agent to pick up.
argument-hint: What will the next session be used for?
disable-model-invocation: true
---

Produce a **briefing**: a compact document that orients an agent arriving cold. No transcript, no noise — only what a blind reader needs to act. Shape it toward the next session's purpose if an argument was provided.

## Steps

1. Scan the conversation for: the goal, key decisions and their rationale, current state (done / in-progress / blocked), files and artifacts touched, and context that won't survive a fresh session. Done when every distinct thread is accounted for.

2. Write the briefing using the template below. Cut anything a cold agent can skip and still act well.

3. Write the briefing to a file named `hand-off-<timestamp>.md` (e.g. `hand-off-2026-07-03T14-32.md`) in the current working directory. Tell the user the filename. Done when the file exists and the user confirms it looks right.

<briefing-template>

## Goal
What we're building or solving, in one or two sentences.

## Context
Stack, codebase conventions, or constraints a fresh agent needs to act safely.

## State
- Done: ...
- In progress: ...
- Blocked: ... (if any)

## Decisions
Key choices made and the brief rationale that closed them. Skip anything obvious.

## Next Steps
Concrete actions for the next session, ordered by priority.

## Artifacts
Files, branches, commands, or error messages the next agent will need. Use `file:line` or `file:function` references where precision matters.

</briefing-template>
