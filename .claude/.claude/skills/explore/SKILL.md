---
name: explore
description: Delegate codebase searches to an Explore subagent so the raw file output never enters your context. Use when you need to find where something lives, how it works across many files, or to confirm a claim about the code.
argument-hint: What do you want found out?
---

Answer the question by **brief**ing `Explore` subagents: their searching burns *their* context, and only the answer returns to yours.

## Steps

1. **Write the brief.** Split the question into independent parts ("where is X", "how does Y work") and write one brief per part. Each carries:
   - **The question**, concretely.
   - **Breadth**: `medium` for a scoped lookup, `very thorough` when it spans multiple locations or naming conventions.
   - **The return shape**: the exact facts asked for, backed by `file:line`. Snippets only when the answer needs them, and no transcript of the search.

2. **Spawn.** One `Explore` per brief (`subagent_type: Explore`, `model: sonnet`), all in a single message so they run in parallel.

3. **Relay.** Done when every part of the question has an answer backed by `file:line`. A report that hedges, or covers only part of its brief, is not done: re-brief a fresh `Explore` with a sharper return shape. Never fall back to searching inline yourself.
