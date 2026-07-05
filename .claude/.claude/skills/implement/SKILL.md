---
name: implement
description: "Implement a piece of work from a plan."
disable-model-invocation: true
---

Work through `plan/plan.md`: execute its Steps in order, each done when its checkable condition holds. (No `plan/plan.md`? use the conversation context)

After each Step completes, append one line to `plan/log.md` (if present): `- [x] <Step> — <brief outcome>`. Gives a resuming agent a breadcrumb trail without re-deriving state from the diff.

Run /tdd at the seams the plan's Testing Decisions named, testing the behaviours it prioritised.

Typecheck and run single test files as you go; run the full suite once at the end.

When every Step is done, run /code-review.
