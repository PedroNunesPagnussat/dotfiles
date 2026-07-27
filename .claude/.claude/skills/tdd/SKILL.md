---
name: tdd
description: Test-driven development — red → green, one seam at a time. Use when the user wants to build a feature or fix a bug test-first, or wants integration tests.
---

# Test-Driven Development

TDD is the red → green loop. Everything here applies on every cycle — consult it during the loop, not after.

## Seams

A **seam** is the public boundary you test at: the interface where you observe behavior without reaching inside. Tests live at seams, never against internals — that's what lets the code change entirely while the tests stand. Name each test for the capability it pins down ("user can checkout with valid cart"), so the suite reads as a specification.

**Test only at pre-agreed seams.** No test is written at a seam the user hasn't confirmed. You can't test everything — agreeing the seams up front is how testing effort lands on the critical paths and complex logic instead of every edge case.

See [tests.md](tests.md) for worked examples and [mocking.md](mocking.md) for what to mock.

## The loop

1. **Agree the seams.** Write down the seams under test and confirm them. Done when the user confirms, or the spec's Testing Decisions already named them.
2. **Red.** One test at one agreed seam. Run it. Done when it fails for the reason you predicted, not a typo or an import error.
3. **Green.** Only enough code to pass it — don't anticipate future tests or add speculative features. Done when the new test and the affected tests pass.
4. Repeat from 2, one **vertical slice** at a time.

Refactoring is not part of the loop. It belongs to the review stage (see the `code-review` skill).

## Anti-patterns

- **Implementation-coupled** — mocks internal collaborators, tests private methods, or verifies through a side channel (querying the database instead of using the interface). The tell: the test breaks when you refactor but behavior hasn't changed.
- **Tautological** — the assertion recomputes the expected value the way the code does (`expect(add(a, b)).toBe(a + b)`, a snapshot derived by hand the same way, a constant asserted equal to itself), so it passes by construction and can never disagree with the code. Expected values must come from an independent source of truth — a known-good literal, a worked example, the spec.
- **Horizontal slicing** — writing all tests first, then all implementation. Bulk tests verify _imagined_ behavior: you test the _shape_ of things rather than user-facing behavior, and you commit to test structure before understanding the implementation. Each slice is a **tracer bullet** instead — let what the last cycle taught you shape the next test.
