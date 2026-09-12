---
name: deep-code-review
description: Review code for correctness bugs and design smells, over the branch diff by default or any path you name.
disable-model-invocation: true
---

# Review

Weigh every item on both passes against every file in scope: an item you cleared counts, one you never looked at doesn't.

## Fresh eyes

You can't review code whose rationale is already in your head: you check it against what you meant, not against what's on the page. So before anything else, ask whether you authored any part of the code in scope, or its reasoning is still in your context (including from a prior session since compacted or resumed).

If so, you're the wrong reviewer. Dispatch one cold-context subagent (general-purpose, never a fork) to run this skill, hand it the invocation argument and nothing else, and tell it the review is read-only: it reports findings and changes no files. Then relay its report, no softening and no quiet drops, since you may have written what it flagged. Where you disagree, keep the finding and add your objection beneath it. That's your entire job this run.

Otherwise run the passes yourself.

## 1. Scope

Take the scope from the invocation argument:

- **no argument**, everything not yet on main: commits and uncommitted work alike, plus its immediate blast radius

      git diff $(git merge-base HEAD origin/main)   # master, or plain main with no remote

  On a branch that base is the fork point, so the whole branch is in scope whether or not it's pushed. On main itself `origin/main` is an ancestor, so the base is the last pushed commit. Work lands here from several sessions and several authors, so don't reach for `git diff HEAD`: it drops every commit.

List the files in scope before you start. That list is what the bar above holds you to.

## 2. Passes

Both of them, against the file list:

| Pass | Read | Hunts |
|---|---|---|
| correctness | [`CORRECTNESS.md`](CORRECTNESS.md) | bugs |
| smells | [`SMELLS.md`](SMELLS.md) | design smells |

## 3. Report

Findings most-severe first, correctness before smells. For each: `file:line`, a one-sentence problem, and a concrete failure scenario or fix. Separate confirmed bugs from lower-confidence suggestions. If the harness offers a structured findings channel, use it. If nothing substantive turns up, say so plainly.

Report first. When the user approves, apply the fixes.
