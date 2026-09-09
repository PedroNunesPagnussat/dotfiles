---
name: brag-document-entry
description: "Fetch Jira issues and write brag-document entries from them: what changed, and why it mattered."
argument-hint: Jira issue key(s) or URL(s), e.g. XXX-949
disable-model-invocation: true
---

# Brag Document Entry

Every entry is **grounded**: each claim traces to ticket text, or to an answer the user gave when asked. What it traces to is the **consequence** — what broke, who was blocked, what it now makes possible. When no consequence surfaces from either source, the entry states none, because an accurate small entry beats an inflated one.

## Steps

1. For each issue key/URL passed in, resolve the key (e.g. `XXX-949`) and the site (hostname from the URL, or for a bare key the Atlassian site you have access to). Fetch it with `getJiraIssue` (cloudId = site, issueIdOrKey = key). The entry link is `https://<site>/browse/<KEY>`. If the summary and description don't state the consequence, re-fetch including `comment`. Once every issue is fetched, ask the user about the ones whose tickets stayed silent — one question covering all of them, not an interruption per issue. Done when every issue either has a consequence, quoted from its ticket or supplied by the user, or has been through the comments and the ask with none surfacing.

2. Pick a shape per issue:
   - **One-liner**: no consequence surfaced, or the change is self-contained and its value is obvious once stated (a UI tweak, a standardization, a small fix).
   - **What / Why**: the ticket involved investigation, a root cause, or a systemic/cross-cutting consequence that isn't obvious from the "what" alone (data-loss risk, a convention now enforced repo-wide, a production incident).

   Test, once a consequence surfaced: read your one-line summary back. If a reader would immediately ask "why does that matter?", use What / Why.

3. Write one entry per issue, in the order passed in, using the template below. Put the whole answer inside a single fenced ` ```markdown ` code block, so it stays raw and pastes into a doc instead of rendering. Done when every issue has exactly one grounded entry and the whole answer sits inside that one fence.

<template>
Emit only the bullet(s) for the shape Step 2 picked — not the shape name below.

One-liner:
- [<KEY>](<link>): <what changed, plus the consequence if one surfaced>.

What / Why:
- [<KEY>](<link>):
    - **What**: <1-2 sentences, concrete>
    - **Why it matters**: <1-2 sentences: the consequence, quoted or paraphrased from its source>
</template>
