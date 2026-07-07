---
name: brag-document-entry
description: "Fetch a Jira issue and write a brag-document entry from it: what it was, and why it mattered."
argument-hint: Jira issue key(s) or URL(s), e.g. XXX-949
disable-model-invocation: true
---

# Brag Document Entry

## Steps

1. For each issue key/URL passed in, resolve the key (e.g. `XXX-949`) and the site (hostname from the URL, or for a bare key the Atlassian site you have access to). Fetch it with `getJiraIssue` (cloudId = site, issueIdOrKey = key). The entry link is `https://<site>/browse/<KEY>`. If the summary and description don't explain why the work mattered, re-fetch including `comment`. Done when you can state, in your own words, what changed and why someone would care.

2. Pick a format:
   - **One-liner**: the change is self-contained and its value is obvious once stated (a UI tweak, a standardization, a small fix).
   - **What / Why**: the ticket involved investigation, a root cause, or a systemic/cross-cutting impact that isn't obvious from the "what" alone (data-loss risk, a convention now enforced repo-wide, a production incident).

   Test: read your one-line summary back. If a reader would immediately ask "why does that matter?", use What/Why.

3. Write the entry using the template below, one per issue, in the order passed in, inside a single fenced ` ```markdown ` code block so the output stays raw and pastes cleanly into a doc instead of being rendered. Done when every issue has exactly one entry and the whole answer is inside that one fence.

<template>
Emit only the bullet(s) for the shape Step 2 picked — not the shape name below.

One-liner:
- [<KEY>](<link>): <what changed, and why it mattered if not self-evident>.

What / Why:
- [<KEY>](<link>):
    - **What**: <1-2 sentences, concrete>
    - **Why it matters**: <1-2 sentences: the consequence, risk, or capability the fix produced>
</template>
