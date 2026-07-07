---
name: to-spec
description: Decompose a shared understanding into a concrete spec that /implement executes.
disable-model-invocation: true
---

Each spec gets its own directory under `specs/` at the repo root, named `spec-{ticket}-{short-desc}` — ticket or issue number optional (e.g. `spec-142-oauth-login` or `spec-oauth-login`). Read and updated across sessions so work can resume where it left off. Inside it:

- `spec-{...}.md` — the spec (template below), same name as the directory.
- `log.md` — append-only record of what's been done.
- `step-{short-desc}.md` — detail for a Step complex enough to need its own sub-steps; the Step links to it.

## Process

1. Explore the codebase to understand the current state, if you haven't already. Respect existing conventions and patterns — the spec should extend them, not contradict them.

2. Identify what the conversation has already resolved and what is still unclear. For unclear points, interview the user one question at a time until everything needed to write the spec is decided.

3. Write the spec using the template below, and create an empty `log.md` beside it. Present the spec and ask if it looks right. Done when the user approves or revises it to their satisfaction. The approved Steps are the contract /implement executes.

<spec-template>

## Background
Discoveries from exploring the codebase and talking with the user — current state, relevant files and patterns, constraints uncovered. The context a fresh agent needs to orient.

## Problem Statement
The problem being solved, from the user's perspective.

## Solution
What we're building, from the user's perspective.

## Decisions
Key resolved choices that will shape the implementation. For each decision, include:
- What was decided
- Why (brief rationale or trade-off that closed the question)
- Alternatives ruled out, if any were considered

Cover: architecture choices, data model changes, API contracts, library/pattern choices, and any technical constraints.

## Testing Decisions
- What makes a good test for this feature (behaviour, not implementation)
- Which seams will be tested
- Prior art in the codebase to follow

## Steps
Checkboxes so a resuming agent sees done-vs-left at a glance. A Step complex enough to need its own sub-steps links to `step-{short-desc}.md`.
- [ ] Step — done when [checkable condition].
- [ ] ...

## Out of scope
- Explicitly excluded alternatives and features.

</spec-template>
