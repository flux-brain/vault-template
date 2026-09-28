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
