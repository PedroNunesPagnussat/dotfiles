---
description: Fetch open tasks from the Todoist "Claude" project
---

Fetch the open tasks from the Todoist project named **Claude** and show them to me.

Steps:
1. Resolve the project by name with `find-projects` (searchText: "claude"). Don't hardcode the ID — it can change.
2. Fetch its open tasks with `find-tasks` (projectId from step 1).
3. List them grouped by section if sections exist, ordered by priority then due date. For each task show: content, priority (if not p4), due date (if any), and any deadline.
4. If there are no open tasks, say so plainly.

$ARGUMENTS
