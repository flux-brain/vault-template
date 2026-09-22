<!-- Optional module: Google Keep checklists. Delete this file if the module is off. -->
# Captures from Google Keep

Read by the inbox run when a capture has `source: keep` (see CLAUDE.md, Ingest).

**Captures from Google Keep (`source: keep` in the frontmatter).** A server script
mirrors every `wiki/projects/` page into Google Keep as a checklist of its `## Next actions`, and sends
the owner's Keep edits back as captures. Two kinds:

- `kind: project-checklist`: the owner edited the Keep checklist of `project: <slug>`. Apply each line to
 `wiki/projects/<slug>.md`. Each line names the action's id when it has one (`done ^a1b2: X`): apply it to the
 page line carrying `^a1b2` and KEEP that id on the line, whatever else changes. Only a line with no id is
 matched by its text, which must then be used EXACTLY as written (a paraphrase leaves the owner's Keep edit hanging
 for two hours); an action the owner added in Keep has no id yet, so mint one when you file it:
 `done: X` → tick `- [x] X` in place (keep the line in `## Next actions`); `reopened: X` → `- [ ] X`;
 `new action: X` → add `- [ ] X`; `new action, already done: X` → add `- [x] X`; `removed: X` →
 delete that line and note it in the log; `reworded: A → B` → replace A with B. Add a short dated
 `## Log` line ("Keep: done X") and set `updated:`. No `notify/` unless a line is ambiguous.
- `kind: keep-note`: a note the owner wrote in Keep and tagged with a project label (`projects:` lists the
 slugs; empty means the label has no page yet, so file by best guess or ask). File it like any
 capture under that project's `## Log`, with the `keep_url`. `update_of_earlier_capture: true` means
 the owner edited a note already filed: update what that earlier capture produced instead of duplicating it.
