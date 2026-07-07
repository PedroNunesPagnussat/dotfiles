---
name: implement
description: "Implement a piece of work from a spec."
disable-model-invocation: true
---

Work through the spec's Steps in order, each done when its checkable condition holds. The spec is the `spec-*.md` under `specs/` for this work; if it's absent or ambiguous, use the conversation context.

After each Step completes, append one line to the spec's `log.md` (if present): `- [x] <Step> — <brief outcome>`. Gives a resuming agent a breadcrumb trail without re-deriving state from the diff.

Always invoke the `/tdd` skill at the seams the spec's Testing Decisions named, testing the behaviours it prioritised.

Typecheck and run single test files as you go; run the full suite once at the end.

When every Step is done, run /code-review.
