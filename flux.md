# Flux owner settings

Claude reads this file at the start of every run (see `CLAUDE.md`, "Owner settings"). Fill it in once;
edit it when something changes. Keep it free of secrets: it is committed to the repository.

## Owner

- Name: `<your name>` (how Claude refers to you in pages and messages)
- Time zone: `<IANA zone, e.g. Europe/Paris>` (all dates on pages are in this zone; the routines run on UTC)

## Writing

- Default language: `English`
- Per-topic languages (optional): `<none>` (example: "French for project X and for French tax topics")
- Rules for text a third party will read (drafts, emails): `<none>` (example: "no en or em dashes")

## Discord

- Capture channel: `#flux` (where you post and where Claude answers and asks)
- Log channel: `#flux-log` (muted; run summaries, run links, "note received" notices)
- Optional channels, each named in the server's `flux.toml` (`[discord]`); delete the lines you do not use.
  Without one, its posts stay in the capture channel. What you write in them is read like a post in `#flux`.
  - Digest channel: `#flux-digest` (the daily digest and the weekly review)
  - Actions channel: `#flux-actions` (posts that wait for a tap: email triage, Drive folder suggestions)
  - Voice channel: `#voice-notes` (voicemail notices)
- Your Discord user id: set on the server side, not here (the relay @mentions you on questions)

## Optional modules (on / off)

- Memory mirror (`memory/`, memory proposals, action ids in memory): `off`
- Google Tasks checklists (`ops/tasks.md`): `off`
- Google Keep checklists (`ops/keep.md`): `off` (not shipped; Tasks replaces it)
- Gmail feed (`ops/gmail.md`): `off`

When a module is off, its `ops/` file may be deleted and Claude ignores the matching rules.
