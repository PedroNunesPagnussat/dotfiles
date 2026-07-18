---
name: explore
description: Delegate codebase searches to an Explore subagent, keeping the raw file output out of the main context. Use when you need to find where something lives, how it works across many files, or to confirm a claim about the code — whenever you want the conclusion, not the dump.
argument-hint: What do you want found out?
---

Spawn an `Explore` subagent to answer the question. Its searching stays in *its* context; only the answer returns to yours. Never search inline instead.

## Steps

1. **State the question.** Take it from the argument, or from what the conversation is trying to find out. If it splits into independent parts ("where is X", "how does Y work"), spawn one `Explore` per part in a single message so they run in parallel.

2. **Brief each agent** (`subagent_type: Explore`) with:
   - **The question**, concretely.
   - **Breadth**: `medium` for a scoped lookup, `very thorough` when it spans multiple locations or naming conventions.
   - **The return shape**: a tight answer, `file:line` pointers, and the exact facts asked for — code snippets or a fuller dump only when the answer needs them. No transcript of the search itself.

3. **Relay the answer** and its `file:line` pointers. Done when the question is answered from the subagent's report. If the report is insufficient, spawn a follow-up Explore with a sharper brief — don't fall back to searching inline yourself.
