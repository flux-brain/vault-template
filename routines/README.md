# Routines

The two Claude Code cloud routines that run the vault. Each file holds the routine's settings and the exact
prompt to paste when creating it at https://claude.ai/code/routines (the prompts are the ones a running Flux
instance uses, with the owner's repository, name and time zone replaced by placeholders).

| File | Routine | Schedule (UTC) | What it does |
|---|---|---|---|
| [vault-inbox.md](vault-inbox.md) | `vault-inbox` | `0 6-20 * * *` (hourly during the day) plus on-demand starts by the relay | Files everything in `inbox/`; on Sunday's last run also writes the weekly review and runs the lint |
| [vault-review.md](vault-review.md) | `vault-review` | `0 5,6 * * *` (two starts, one does the work at your local `<review-hour>`) | Files any leftover captures, then writes the daily digest |

Common settings for both:

- **Source:** your vault repository (the one made from this template), branch `main`.
- **Model:** `claude-sonnet-5` is enough; the rules do the work.
- **Tools:** `Bash`, `Read`, `Write`, `Edit`, `Glob`, `Grep`. No connectors: the routine only talks to git.
- **Environment:** the default cloud environment.
- **API trigger token:** generate one for `vault-inbox` only, and put it in the server's `flux.env` as
  `ROUTINE_FIRE_TOKEN`; the relay uses it to start a run the moment a capture arrives. `vault-review` needs none.

Before pasting, replace in each prompt:

- `<owner>/<vault>` with your repository, for example `ann/vault`;
- `<Owner>` with your first name, as written in `flux.md`;
- `<TZ>` with your IANA time zone, for example `Europe/Paris`;
- in `vault-inbox`, `<weekly-hour>` with the LOCAL hour (two digits) of the Sunday run that also writes the weekly
  review; it must fall inside the schedule in both summer and winter time, for example `21` with the schedule
  above and Paris time (the check compares `TZ=<TZ> date +%u%H` with `7<weekly-hour>`);
- in `vault-review`, `<review-hour>` with the LOCAL hour (two digits) you want the digest, for example `07`.

Both checks read your local clock, so nothing needs changing when the clocks go forward or back. If you move to
another time zone, change `<TZ>` (and, for `vault-review`, the two UTC hours of its schedule).

The schedule minimum is one hour; the relay covers everything faster than that.
