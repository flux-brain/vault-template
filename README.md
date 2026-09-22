# Flux vault template

The memory half of **Flux**, a personal AI assistant built on a second-brain structure: an Obsidian
vault that Claude maintains for you using the LLM Wiki pattern. You capture; Claude files, links,
summarises, drafts, reviews and asks you questions. You read the result in Obsidian on your phone or
laptop and talk to it through a Discord channel.

This repository is a **template**: press "Use this template" on GitHub to get your own private copy.
It contains the rules Claude follows (`CLAUDE.md`), the folder layout, the page template and the
instructions for the daily digest and the weekly review. It contains no content.

```
Discord #flux ──(server relay, every 15 s)──> inbox/ ──(Claude routine, started right away)──> wiki/ + raw/
                                                                    │
Discord #flux ◄──(relay)── notify/ answers, questions, briefings ◄──┘
Discord #flux-log ◄──(relay, muted)── run links, "Filed" summaries
```

## What you need

1. A private GitHub repository made from this template.
2. A Claude Code subscription that includes cloud routines (scheduled runs that can be started on
   demand through an API trigger). The routines do the filing; see "Routines" below.
3. A small always-on machine (a home server, a VPS) for the relay that connects Discord to the
   repository. The relay lives in the companion server repository; without it you can still use the
   vault by writing notes straight into `inbox/` from Obsidian and letting the hourly routine file them.
4. Obsidian on your devices. On Android, GitSync keeps the phone copy in step; on a laptop, git or the
   Obsidian Git plugin.

## Set up

1. Create the repository from the template, private.
2. Edit `flux.md`: your name, time zone, languages, channel names, which optional modules are on.
   Delete the `ops/` files of modules you do not use.
3. Create the two routines (below) and note the trigger token of the inbox one for the relay.
4. Install the relay on your server (companion repository) with your Discord bot, channel names and
   the trigger token.
5. Open the repository in Obsidian. Post something in `#flux`. Within a few minutes it is filed under
   `wiki/` and Claude tells you what it did.

## Routines

Two routines, both with this repository as their working copy and `CLAUDE.md` as their instructions:

| Routine | Schedule (UTC) | Prompt |
|---|---|---|
| `vault-inbox` | hourly during your day, e.g. `0 6-20 * * *`, plus on-demand starts by the relay | "Read CLAUDE.md and run the inbox protocol. On Sundays at the last run of the day also run the weekly review." |
| `vault-review` | once a day, e.g. `0 5 * * *` | "Read CLAUDE.md and write the daily digest (ops/daily-digest.md)." |

Give the routines the tools Bash, Read, Write, Edit, Glob and Grep, and no connectors. Generate an
API trigger token for `vault-inbox`; the relay uses it to start a run the moment a capture arrives and
posts the run link to `#flux-log` so you can watch Claude work.

## How it works, in short

- **Capture:** post text, links, photos, PDFs, voice memos in `#flux`. The relay files each message
  into `inbox/` within about 15 seconds and reacts to confirm. Or write a note straight into `inbox/`
  from Obsidian.
- **Attachments:** the original goes to your cloud storage folder; its text (PDF text or OCR, images,
  Office files, emails, transcribed audio) goes to `raw/attachments/` so Claude can read it.
- **Processing:** the relay starts the `vault-inbox` routine right away, so results usually come back
  in two to three minutes; the hourly run is the backstop.
- **Answers and drafts** arrive in `notify/` and are posted to `#flux`, ready to copy. **Questions**
  from Claude @mention you. Answer by replying in the channel; the answer comes back through the inbox.
- **Reviews:** a daily digest and, on Sundays, a weekly project review, posted to `#flux`.
- **Optional modules** (each documented in the server repository): a read-only mirror of your Claude
  Code memory into `memory/`, Google Keep checklists for every project page, a Gmail label feed.

## Privacy by design

Flux never reads your private conversations with other people (messaging apps). Nothing from them
enters this repository, and the routines have no way to reach them. See `CLAUDE.md`, "Privacy of
private conversations".

## Licence

Apache License 2.0; see `LICENSE` and `NOTICE`.
