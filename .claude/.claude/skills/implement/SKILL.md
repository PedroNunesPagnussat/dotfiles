---
name: implement
description: "Implement a piece of work based on a PRD or set of issues."
disable-model-invocation: true
---

Work through `PLAN.md`: execute its Steps in order, each done when its checkable condition holds. (No `PLAN.md`? use the conversation context)

Run /tdd at the seams the plan's Testing Decisions named, testing the behaviours it prioritised.

Typecheck and run single test files as you go; run the full suite once at the end.

When every Step is done, run /code-review.
