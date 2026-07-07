---
name: implement
description: "Implement a piece of work from a spec."
disable-model-invocation: true
---

Find the spec: the `specs/spec-*/spec-*.md` for this work. If it's absent or ambiguous, use the conversation context.

Work through the spec's Steps in order. For each Step:

- Read any `step-*.md` it links; that file holds the Step's detail.
- Always invoke the `/tdd` skill to build it, at the seams the spec's Testing Decisions named, testing the behaviours it prioritised.
- Typecheck and run the affected test files as you go.
- Done when the Step's checkable condition holds. If the spec exists, append one line to its `log.md`: `- [x] <Step> — <brief outcome>`.

When every Step is done, run the full test suite, then run /code-review.
