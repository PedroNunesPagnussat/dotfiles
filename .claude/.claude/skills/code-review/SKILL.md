---
name: code-review
description: Review code for correctness bugs and design smells, over the branch diff by default or any path you name. Use after implementing a change, when the user asks for a review, or when cleaning up smells in existing code.
---

# Review

Weigh every item on both lists below against every file in scope: an item you cleared counts, one you never looked at doesn't. Telling is narrower than looking.

An input-shape finding needs evidence the bad input occurs: a caller that produces it, a test that feeds it, or a stated requirement that permits it. Without that you invented the input, and the finding is speculative. Speculative findings stay out of the report. Security is the exception, kept to what is cheap to see: injection, unsanitized input reaching a sink, committed secrets.

## Fresh eyes

You can't review code whose rationale is already in your head — you check it against what you meant, not against what's on the page. So before anything else: did you author any part of the code in scope, or is its reasoning still in your context (including from a prior session since compacted or resumed)?

If so, you're the wrong reviewer. Dispatch a cold-context subagent (general-purpose, never a fork) to run this skill, hand it the scope and nothing else, and relay its report. That's your entire job this run.

## 1. Scope

Take the scope from the invocation argument:

- **no argument** — the branch diff, every change committed and uncommitted, plus its immediate blast radius:

      git diff $(git merge-base HEAD main)   # master if the repo has no main

- **a path** — that file or directory
- **`.`** — the repo

List the files in scope before you start. That list is what the bar above holds you to.

## 2. Correctness

Stay inside the scope and its blast radius.

- Logic errors: off-by-one, wrong operator, inverted condition
- Unhandled errors, nil/None/undefined, empty-collection and boundary cases
- Concurrency issues and resource leaks (unclosed files/connections)
- Broken, missing, or implementation-coupled tests for the behaviour in scope

## 3. Standards

First run whatever linters and formatters the repo configures (pyproject.toml, package.json, .pre-commit-config.yaml, Makefile) in check mode — `--check`, `--dry-run`, `--no-fix` — so nothing gets rewritten. They own the mechanical violations; let them report those.

Then walk the smell baseline against the scope, for the design smells tooling can't see. Each smell is a heuristic, never an automatic fail; skip anything the tooling already enforces or allows.

When a smell recurs past the scope, sweep it: follow that one smell as far as it goes, stopping at the edge of its module or layer. One finding for the sweep, anchored at the worst site and naming the rest.

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
- **Dead Code** — unreachable branches, unused params, leftover debug output. → remove it.

## 4. Report

List findings most-severe first. For each: `file:line`, a one-sentence problem, and a concrete failure scenario or fix. Separate confirmed bugs from lower-confidence suggestions. If the harness offers a structured findings channel, use it. If nothing substantive turns up, say so plainly.

Report first. When the user approves, apply the fixes.
