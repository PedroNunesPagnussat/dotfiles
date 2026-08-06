---
name: implement
description: Implement a piece of work from a spec.
disable-model-invocation: true
---

Find this work's spec: `specs/spec-*/spec-*.md`. If several match, ask which. If none exists, agree the Steps, their checkable done-conditions, and the seams to test with the user before building.

Work through the Steps in order. For each Step:

- Read any `step-*.md` it links; that file holds the Step's detail.
- Always invoke the `/tdd` skill to build it.
- Typecheck as you go.
- Append one line to the spec's `log.md`: `- [x] <Step> — <brief outcome>`.
- Done when the Step's checkable condition holds.

If a Step can't be built as specified, append `- [ ] <Step> — blocked: <what the spec assumed, what's actually true, what you tried>` and take it back to the user.

When every Step is done, run the full test suite, then run /code-review.
