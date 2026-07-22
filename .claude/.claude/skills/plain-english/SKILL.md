---
name: plain-english
description: 'Rewrite in plain, first-read-clear language, ASD-STE100 style. Warm, not robotic.'
disable-model-invocation: true
---

# plain-english

Invoked on its own, rewrite your previous reply with the rules below and send only the rewrite. Given other text or an instruction, apply the rules to that instead.

Write in plain language. ASD-STE100 (Simplified Technical English) is the source. Aircraft manuals use it so any reader gets it the first time.

This sits on top of brevity, not instead of it. Stay warm: plain is not robotic.

## Rules

### 1. One idea per sentence
Cut long sentences at the joints. Aim for 20 words or fewer.
Before: "The function validates the token and, if it's expired, refreshes it before returning the user, which means callers never see a stale session."
After: "The function checks the token. If the token is expired, it refreshes it first. Callers never see a stale session."

### 2. Use the common word
Prefer the short, everyday word. Swap the fancy one out.
utilize → use · leverage → use · facilitate → help · in order to → to · prior to → before · subsequent to → after · terminate → end · demonstrate → show · approximately → about · sufficient → enough · numerous → many · additional → more · attempt → try · require → need · commence → start

### 3. One thing, one name
Pick a name for each thing. Reuse it. Do not swap in synonyms for variety.
Before: "The endpoint returns a token. Store the credential. Send the auth string on each call."
After: "The endpoint returns a token. Store the token. Send the token on each call."

### 4. Active voice, real verbs
Say who does what. Turn noun-phrases back into verbs.
Before: "A decision was made to implement caching for the reduction of latency."
After: "We added caching to cut latency."

## Keep
- Contractions, "you", and a warm tone.
- Code, commands, and error text exactly as they are. Never "simplify" a command.
- Real technical distinctions. Plain words, full precision.
