---
name: deep-code-review
description: Review code for correctness bugs and design smells, over the branch diff by default or any path you name.
disable-model-invocation: true
---

# Review

You run this review by dispatching it, not by doing it: resolve the scope, send two cold-context subagents out on it, merge what they bring back. Fresh eyes are the point — you may have written the code, and a reviewer holding the rationale checks the code against what it meant rather than against what's on the page.

## 1. Scope

The current branch by default: every change committed and uncommitted, plus its immediate blast radius.

    git diff $(git merge-base HEAD main)   # master if the repo has no main

An argument overrides it — a path scopes to that file or directory, `.` to the whole repo.

List the files in scope before you dispatch. That list is what both agents are held to.

## 2. Dispatch

Two general-purpose subagents (never a fork), both in one message so they run in parallel:

| Agent | Reads | Hunts |
|---|---|---|
| correctness | [`CORRECTNESS.md`](CORRECTNESS.md) | bugs |
| smells | [`SMELLS.md`](SMELLS.md) | design smells |

Hand each the file list, the absolute path to its pass file, and this report format:

> Findings most-severe first. For each: `file:line`, a one-sentence problem, and a concrete failure scenario or fix. Separate confirmed bugs from lower-confidence suggestions. If nothing substantive turns up, say so plainly.

## 3. Merge

Relay both reports as written. You may have authored the code under review, so leave every finding standing: no softening, no quiet drops. Where you disagree, keep the finding and add your objection as a note beneath it.

Correctness findings lead, smells follow. Collapse findings both agents raised on the same line into one. If the harness offers a structured findings channel, use it.

Report first. When the user approves, apply the fixes.
