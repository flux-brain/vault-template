# Routines

The two Claude Code cloud routines that run the vault. Each file holds the routine's settings and the exact
prompt to paste when creating it at https://claude.ai/code/routines (the prompts are the ones a running Flux
instance uses, with the owner's repository, name and time zone replaced by placeholders).

| File | Routine | Schedule (UTC) | What it does |
|---|---|---|---|
| [vault-inbox.md](vault-inbox.md) | `vault-inbox` | `0 6-20 * * *` (hourly during the day) plus on-demand starts by the relay | Files everything in `inbox/`; on Sunday's last run also writes the weekly review and runs the lint |
| [vault-review.md](vault-review.md) | `vault-review` | `0 5 * * *` (one run a day, before your morning) | Files any leftover captures, then writes the daily digest |

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
- in `vault-inbox`, `<weekly-hour>` with the UTC hour of the last hourly run on Sunday, as two digits: with the
  schedule above and Paris time it is `17` (the check compares `date -u +%u%H` with `7<weekly-hour>`).

The schedule minimum is one hour; the relay covers everything faster than that.
