<!-- Optional module: memory mirror. Delete this file if the module is off. -->
# Captures from the memory store

Read by the inbox run when a capture has `source: memory`, `kind: reconcile`. The rules for writing memory proposals stay in CLAUDE.md.

**Captures from the memory store (`source: memory`, `kind: reconcile`).** The server writes one per page when memory
files mapped to it change (`page:` is the slug, `changed:` the files). Reconcile that page's `## Next actions`
against the changed files, reading other `memory:` files only if needed:
- tick `- [x]` an action memory now records as done, sent, closed, resolved or struck (`~~text~~`), keeping its
 trailing `^id` exactly as it stands;
- add `- [ ]` an open item memory marks as open, pending or ⚠ that belongs to this project and is not on the page,
 minting a fresh four-character `^id` for it and naming that id in the filed summary, so a session can carry it
 to the memory line;
- reword an action whose memory item materially changed (a date, a blocker, a counterpart), keeping it ONE line
 AND keeping its `^id`: the id is what lets the server strike the right memory line later, and a reword that
 mints a new id breaks that link silently;
- never delete an action, never untick one unless memory explicitly says it reopened, never copy figures a line
 does not need, never copy secrets; when memory contradicts a later edit by the owner on the page, keep the owner's version
 and ask in `notify/`.
Add a dated `## Log` line ("Memory: ticked X, added Y") and set `updated:` only when the page changed. If nothing
needs changing, just file the capture with its `log.md` line. In the run's filed summary, list it only when the
page changed (`Memory: <page> -> ticked X`). **Never write a memory proposal for changes made from these captures.**

**Diff blocks .** Each changed file normally comes with a fenced `diff` block under `## Changes`
showing what that mirror push changed (`+` added lines, `-` removed lines, a few lines of context). Reconcile
from those blocks. Open the full memory file only when its block says `(diff truncated)`, when a file in
`changed:` has no block (a change to the file's frontmatter only, carried along so it is not lost), or when you
cannot place an item from the diff alone. A capture without `## Changes` (older format) means: read the files.

**`(diff truncated)` is an order, not a hint.** A cut block, and above all an EMPTY one, hides part of what changed.
Before you tick, reword or leave alone any action of the page that this memory file covers:
1. read that memory file (the whole file, or `grep -n` it for each action's subject and `^id`);
2. for EVERY open action of the page tied to that file, check its status in the file, whether or not the visible
   diff mentions it: sent, done, signed, paid, closed, received, and their struck `~~text~~` forms;
3. tick what the file records as done, even when the part of the diff you could see only shows a rewording.
A block may be followed by `Status words in the cut part`: snippets the server found around status words in the text
that was cut. They are leads: confirm each in the file, then act on it. Rewording an action from a cut diff without
this check is how a sent email stays listed as "not sent"; never state "not sent", "not done" or "pending" on a page
from a truncated diff alone.
