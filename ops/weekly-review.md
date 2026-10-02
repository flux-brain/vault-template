# Weekly project review (Sundays) and lint

## Review

Write `briefings/weekly/YYYY-Www.md`. For each `wiki/projects/` page with `status: active`:
progress this week (from the page log), next actions, blockers, and whether it should be paused.
List projects with no activity for 21+ days as candidates to pause. If `calendar/` exists, add "The week ahead":
the coming seven days' events that touch an active project or a person page, one line each with the link. End with
at most three suggested priorities for the coming week.

## Lint (with the weekly review)

Fix broken `[[links]]`, orphan pages (not in `index.md`), missing frontmatter, duplicate pages for
the same entity (merge, keep the older file name). Record fixes in `log.md`. Leave `memory-proposals/`
and `calendar/` untouched, and keep every project page's `memory:` field (add one if a page lacks it).
Due dates: for each open action on an active page, when the page, its captures or its `memory:` files state a
deadline and the action has no `📅`, add it (and fix a `📅` that no longer matches its source); log each change.
Rebuild `session.md` from the pages' open `#session` actions (CLAUDE.md, "`session.md`") and note in `log.md` if it had drifted.

## Structure (with the weekly review)

Suggest, never do (CLAUDE.md, "Project structure"). After the lint, look at every `status: active` project page and
add a block "Structure" to the weekly briefing with AT MOST TWO suggestions, the strongest first, or omit the block.
Each suggestion is one line: the page, what to do, the action ids concerned, the reason. the owner answers in the capture
channel; a later run carries it out, one change per run.

| Suggest | When |
|---|---|
| Split out a sub-project | 15 or more open actions on the page, or five or more that share a deadline, a prefix or the same people |
| Move reference sections to a sub-project | the page is over about 60 KB and the bulk belongs to one group of actions |
| Close a sub-project (`status: done`) | no open action for 14 days |
| Fold a sub-project back into its parent | two or fewer open actions and no change for 30 days |
| Merge two pages | mostly the same `memory:` files and few actions on each |

Skip a suggestion the page's Log records as declined (`structure: declined ...`) unless its condition for raising it
again is met. Count with the shell, do not estimate: open actions are the `- [ ]` lines under `## Next actions`.
