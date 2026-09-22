<!-- Optional module: Google Tasks checklists. Delete this file if the module is off. -->
# Captures from Google Tasks

Read by the inbox run when a capture has `source: tasks` (see CLAUDE.md, Ingest).

**Captures from Google Tasks (`source: tasks` in the frontmatter).** A server script
mirrors every active `wiki/projects/` page into Google Tasks as a list of its `## Next actions`, and sends
the owner's Tasks edits back as captures. One kind:

- `kind: project-checklist`: the owner edited the Tasks list of `project: <slug>`. Apply each line to
 `wiki/projects/<slug>.md`. Each line names the action's id when it has one (`done ^a1b2: X`): apply it to the
 page line carrying `^a1b2` and KEEP that id on the line, whatever else changes. Only a line with no id is
 matched by its text, which must then be used EXACTLY as written (a paraphrase leaves the owner's Tasks edit hanging
 for two hours); an action the owner added in Tasks has no id yet, so mint one when you file it:
 `done: X` → tick `- [x] X` in place (keep the line in `## Next actions`); `reopened: X` → `- [ ] X`;
 `new action: X` → add `- [ ] X`; `new action, already done: X` → add `- [x] X`; `removed: X` →
 delete that line and note it in the log; `reworded: A → B` → replace A with B. Add a short dated
 `## Log` line ("Tasks: done X") and set `updated:`. No `notify/` unless a line is ambiguous.
