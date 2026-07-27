---
name: code-review
description: Review the current branch's changes for correctness bugs, standards violations, and design smells before finishing a piece of work. Use after implementing a change, or when the user asks to review the branch.
---

# Review

Two passes over the diff. A pass is done when every item on its list has been weighed against the diff — an item you cleared counts, one you never looked at doesn't.

## Fresh eyes

You can't review code whose rationale is already in your head — you check it against what you meant, not against what's on the page. So before anything else: did you author any part of this diff, or is its reasoning still in your context (including from a prior session since compacted or resumed)?

If so, you're the wrong reviewer — spawn a sub-agent with clean context (hand it the whole diff, not your rationale) to run this skill, then relay its report. That's your entire job this run.

## 1. Scope

Diff the working tree against the branch point, which covers every change on the branch, committed and uncommitted:

    git diff $(git merge-base HEAD main)   # master if the repo has no main

Review those changes and their immediate blast radius.

## 2. Correctness

- Logic errors: off-by-one, wrong operator, inverted condition
- Unhandled errors, nil/None/undefined, empty-collection and boundary cases
- Concurrency issues and resource leaks (unclosed files/connections)
- Broken, missing, or implementation-coupled tests for the new behavior
- Security: injection, unsanitized input, committed secrets

## 3. Standards

First run the repo's own linters and formatters in check mode (`--check`, `--dry-run`, `--no-fix`), so nothing gets rewritten — whatever the repo configures (look in pyproject.toml, package.json, .pre-commit-config.yaml, or the Makefile). They own the mechanical violations; let them report those.

Then walk the smell baseline below against the diff, for the design smells tooling can't see. Each smell is a heuristic, never an automatic fail; skip anything the tooling already enforces or allows.

- **Mysterious Name** — a name that doesn't reveal what it does or holds. → rename it; if no honest name comes, the design's murky.
- **Duplicated Code** — the same logic shape in more than one hunk or file. → extract the shared shape, call it from both.
- **Feature Envy** — a method that reaches into another object's data more than its own. → move it onto the data it envies.
- **Data Clumps** — the same few fields or params keep travelling together. → bundle them into one type, pass that.
- **Primitive Obsession** — a primitive or string standing in for a domain concept. → give the concept its own small type.
- **Repeated Switches** — the same switch/if-cascade on the same type recurs. → replace with polymorphism, or one shared map.
- **Shotgun Surgery** — one logical change forces scattered edits across many files. → gather what changes together into one module.
- **Divergent Change** — one module edited for several unrelated reasons. → split so each changes for one reason.
- **Speculative Generality** — abstraction or hooks added for needs the spec doesn't have. → delete it; inline back until a real need shows.
- **Message Chains** — long a.b().c().d() navigation the caller shouldn't depend on. → hide the walk behind one method on the first object.
- **Middle Man / Shallow Module** — a unit that mostly delegates onward, or whose interface is nearly as complex as what it hides (Ousterhout, *A Philosophy of Software Design*). → cut it and call the real target, or deepen it behind a simpler interface.
- **Refused Bequest** — a subclass that ignores most of what it inherits. → drop the inheritance, use composition.
- **Dead weight** — unreachable code, unused params, leftover debug output. → remove it.

## 4. Report

List findings most-severe first. For each: `file:line`, a one-sentence problem, and a concrete failure scenario or fix. Separate confirmed bugs from lower-confidence suggestions. If nothing substantive turns up, say so plainly — don't invent findings.

Report first; only fix when the user asks.
