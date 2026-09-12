---
name: deep-code-review
description: Review code for correctness bugs and design smells, over the branch diff by default or any path you name.
disable-model-invocation: true
---

# Review

You scope the review and merge the results. The two passes run in subagents, never in your own context: they hunt different things, and a cold reader beats one checking the code against what it meant rather than against what's on the page.

## 1. Scope

Take the scope from the invocation argument:

- **no argument**, everything not yet on main: commits and uncommitted work alike, plus its immediate blast radius

      git diff $(git merge-base HEAD origin/main)   # master, or plain main with no remote

  On a branch that base is the fork point, so the whole branch is in scope whether or not it's pushed. On main itself `origin/main` is an ancestor, so the base is the last pushed commit. Work lands here from several sessions and several authors, so don't reach for `git diff HEAD`: it drops every commit.

List the files in scope before you dispatch. That list is what both passes are held to.

## 2. Dispatch

Two general-purpose subagents (never forks), in parallel, one per pass:

| Pass | Reads | Hunts |
|---|---|---|
| correctness | `CORRECTNESS.md` | bugs |
| smells | `SMELLS.md` | design smells |

Hand each one the file list from §1, the absolute path to its pass file in this skill's directory, and the rule that the review is read-only: it reports findings and changes no files. Nothing else, and never your own read of the code. This skill is user-invocable only, so a subagent can't reach it by name; the path is how it gets its instructions.

## 3. Report

Merge both reports, most-severe first, correctness before smells. Relay what came back, no softening and no quiet drops, since you may have written what they flagged. Where you disagree, keep the finding and add your objection beneath it. If the harness offers a structured findings channel, use it. If nothing substantive turns up, say so plainly.

Report first. When the user approves, apply the fixes.
