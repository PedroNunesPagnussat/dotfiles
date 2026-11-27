---
description: Open a file's git diff (HEAD vs working copy) in VS Code's diff view
argument-hint: [file]
---

Open `$ARGUMENTS` as a VS Code diff (HEAD on the left, working copy on the right). No argument: do this for every file from `git diff --name-only HEAD`.

For each tracked, modified file:
1. Write the HEAD version to the session scratchpad (or a temp dir if none): `git show HEAD:./<path>` (relative to cwd — `./` is required, the repo-root-relative form fails in nested repos) `> <scratchpad>/<name>`.
2. `code --diff <scratchpad-copy> <file>`.

Untracked/new files: just `code <file>`.

Reply in one line after opening.
