---
name: to-spec
description: Decompose a shared understanding into a concrete spec that /implement executes.
disable-model-invocation: true
---

Each spec gets its own directory under `specs/` at the repo root, named `spec-{ticket}-{slug}` — ticket or issue number optional (e.g. `spec-142-oauth-login` or `spec-oauth-login`). Inside it:

- `spec-{...}.md` — the spec (template below), same name as the directory.
- `log.md` — append-only record of what's been done.
- `step-{n}-{slug}.md` — detail for a Step that isn't **atomic**, numbered by its position in the Steps list; the Step links to it with an explicit markdown link (e.g. `[details](step-3-oauth-callback.md)`). A Step is atomic when one checkable condition settles it.

## Process

1. Understand the current state of the codebase, reaching for the explore skill for anything you haven't already established. Done when you could write the spec's Background section from what you found — the files, patterns, and constraints this spec has to extend.

2. Identify what the conversation has already resolved and what is still open. Route every open decision through the grill-me skill. Done when you could write the spec's Decisions section from what's settled — nothing the spec needs left open.

3. Present the Step list in the conversation before writing it into the spec — each Step phrased as it will appear, with its checkable done-condition — and get the user's read on shape and ordering. Done when the user is satisfied with the Steps.

4. Write the spec using the template below, folding in the agreed Steps, and create an empty `log.md` beside it. Present the spec and ask if it looks right. Done when the user approves it.

5. Break down the Steps that aren't atomic, going through the approved Steps one at a time. Atomic Steps stay inline; every other Step gets its `step-{n}-{slug}.md` holding its sub-steps. Done when every approved Step is either left inline as atomic or has its file written and linked.

Then tell the user to run /implement.

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
- [ ] 1. Step — done when [checkable condition].
- [ ] N. ...

## Out of scope
- Explicitly excluded alternatives and features.

</spec-template>
