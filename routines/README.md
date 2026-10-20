# Routines

The one Claude Code cloud routine that runs the vault. The file holds the routine's settings and the exact prompt
to paste when creating it at https://claude.ai/code/routines (the prompt is the one a running Flux instance uses,
with the owner's repository, name and time zone replaced by placeholders).

| File | Routine | Schedule (UTC) | What it does |
|---|---|---|---|
| [vault-inbox.md](vault-inbox.md) | `vault-inbox` | `30 * * * *` (every hour) plus on-demand starts by the relay | Files everything in `inbox/`; the first run at or after `<day-hour>` local time also writes Your day ahead, the Sunday `<weekly-hour>` run Your week ahead and the lint |

Settings:

- **Source:** your vault repository (the one made from this template), branch `main`.
- **Model:** `claude-sonnet-5` is enough; the rules do the work.
- **Tools:** `Bash`, `Read`, `Write`, `Edit`, `Glob`, `Grep`. No connectors: the routine only talks to git.
- **Environment:** the default cloud environment.
- **API trigger token:** generate one and put it in the server's `flux.env` as `ROUTINE_FIRE_TOKEN`; the relay
  uses it to start a run the moment a capture arrives.

Before pasting, replace in the prompt:

- `<owner>/<vault>` with your repository, for example `ann/vault`;
- `<Owner>` with your first name, as written in `flux.md`;
- `<TZ>` with your IANA time zone, for example `Europe/Paris`;
- `<day-hour>` with the LOCAL hour (two digits) from which Your day ahead is written, for example `06`: with the
  schedule above it is ready about five minutes after half past that hour (the runs until noon retry);
- `<weekly-hour>` with the LOCAL hour (two digits) of the Sunday run that writes Your week ahead, for example `15`
  (the check compares `TZ=<TZ> date +%u%H` with `7<weekly-hour>`).

Both checks read your local clock, so nothing needs changing when the clocks go forward or back. If you move to
another time zone, change `<TZ>`.

The schedule minimum is one hour; the relay covers everything faster than that.
