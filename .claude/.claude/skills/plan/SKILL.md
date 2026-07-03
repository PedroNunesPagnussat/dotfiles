---
name: plan
description: Decompose a shared understanding into a concrete implementation plan. Use when the user asks to plan, spec out, or document what to build.
disable-model-invocation: true
---

## Process

1. Explore the codebase to understand the current state, if you haven't already. Respect existing conventions and patterns — the plan should extend them, not contradict them.

2. Identify what the conversation has already resolved and what is still unclear. For unclear points, interview the user one question at a time until everything needed to write the plan is decided.

3. Write the plan using the template below. Present it and ask if it looks right. Done when the user approves or revises it to their satisfaction.

<plan-template>

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
1. Step — done when [checkable condition].
2. ...

## Out of scope
- Explicitly excluded alternatives and features.

</plan-template>
