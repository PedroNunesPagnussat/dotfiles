---
name: orchestrate
description: Run a spec's Steps through cold subagents, one per Step, so the last Step lands in as clean a context as the first.
disable-model-invocation: true
---

Find this work's spec: `specs/spec-*/spec-*.md`. If several match, ask which. Read it and its `log.md` before dispatching anything.

You orchestrate; each Step is built by a **cold** subagent — one that has read nothing but the brief you write it. You read only the spec, its `log.md`, and the reports that come back; source files, test runs, and diffs stay in the subagent that produced them. That is what keeps the last Step as sharp as the first.

Work through the Steps in order, starting at the first one `log.md` doesn't record as done. For each Step:

- **Brief.** Write the `<brief>` below, then dispatch one `general-purpose` subagent carrying it. The spec is written for a reader who followed the earlier Steps; your subagent didn't, so the brief carries what the Step leaves implicit. Done when the brief would stand alone for a cold reader.
- **Log.** Append the report to the spec's `log.md` in the `<entry>` format. A report missing Changed or Verdict is not done — send the subagent back for it before you log. Done when a cold agent could take the next Step from `log.md` alone.

Run the Steps through without stopping. Two things stop you: a `blocked` verdict, or a report whose Changed doesn't answer the Step's done-condition. Log it in the `<entry>` blocked form and take it back to the user.

When every Step is logged done, run the full test suite, then run /code-review.

<brief>

- Paths to the spec and to the Step's `step-*.md`, if it links one. The subagent reads them itself.
- The Step, verbatim, with its done-condition.
- The seams from Testing Decisions this Step tests at.
- What the earlier Steps built that this one touches — interfaces, names, helpers — drawn from `log.md`.
- Standing orders: invoke the `/tdd` skill to build it, typecheck as you go, change only what this Step calls for.
- The `<report>` shape below, as the required return.

</brief>

<report>

- **Changed** — files touched, with `file:line` on the entry points.
- **Decisions** — what a later Step must respect: interfaces, names, helpers introduced. Empty when the Step invented nothing.
- **Verdict** — `done` when the Step's condition holds, or `blocked: <what the spec assumed, what's actually true, what you tried>`.

</report>

<entry>

- [x] <Step>dad: `- [ ] <Step> — blocked: <the report's verdict, verbatim>`, keeping the Changed line.

</entry>
