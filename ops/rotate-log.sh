#!/bin/sh
# Keep log.md small enough to be read whole. Run by the daily review run (ops/daily-digest.md, last step), from the
# repository root: sh ops/rotate-log.sh
# Every dated line older than KEEP_DAYS days is MOVED, unchanged and in order, to log/<ISO year>-W<week>.md (the same
# week naming as briefings/weekly/). Lines are never edited; the header and any undated line stay in log.md.
# Why: log.md grew by 25 to 35 KB a day and passed the 256 KB a run can read in one go.
# Needs GNU date (the cloud sandbox has it). Changes nothing when no line is old enough, and stops before writing
# anything if a date cannot be read or a line would be lost.
set -eu
KEEP_DAYS=${KEEP_DAYS:-3}
[ -f log.md ] || { echo "rotate-log: no log.md here"; exit 1; }
cut=$(date -u -d "$KEEP_DAYS days ago" +%F)
map=$(mktemp); keep=$(mktemp)
trap 'rm -f "$map" "$keep"' EXIT
# One "<date> <week file>" pair per distinct old date; a date that cannot be read stops the script here.
for d in $(awk -v cut="$cut" '/^20[0-9][0-9]-[0-9][0-9]-[0-9][0-9] / { d = substr($0, 1, 10); if (d < cut && !s[d]++) print d }' log.md); do
  echo "$d log/$(date -u -d "$d" +%G-W%V).md" >> "$map"
done
[ -s "$map" ] || { echo "rotate-log: nothing older than $cut"; exit 0; }
before=$(wc -l < log.md)
mkdir -p log
for f in $(awk '{ print $2 }' "$map" | sort -u); do
  [ -f "$f" ] || printf '# Log, week %s\n\n<!-- Lines moved here from log.md by ops/rotate-log.sh; never edited. -->\n\n' "$(basename "$f" .md)" > "$f"
done
moved=$(awk -v cut="$cut" -v map="$map" -v keep="$keep" '
  BEGIN { while ((getline l < map) > 0) { split(l, a, " "); w[a[1]] = a[2] } }
  /^20[0-9][0-9]-[0-9][0-9]-[0-9][0-9] / { d = substr($0, 1, 10); if (d < cut) { print >> w[d]; n++; next } }
  { print > keep }
  END { print n + 0 }' log.md)
after=$(wc -l < "$keep")
if [ $((after + moved)) -ne "$before" ]; then
  echo "rotate-log: line count mismatch ($before before, $after kept, $moved moved): log.md left as it was, check log/"; exit 1
fi
cat "$keep" > log.md
echo "rotate-log: moved $moved line(s) older than $cut, log.md keeps $after"
