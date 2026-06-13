local description="$(sed -E 's/\bpri:[A-Z]\b//g; s/@[A-Za-z0-9_]+\b//g; s/\+[A-Za-z0-9_]+\b//g; s/[[:space:]]+/ /g; s/^ //; s/ $//' <<<"${args[task]}")"
local pri="$(grep -oP 'pri:\K[A-Z]' <<<"${args[task]}")"
[ -n "$pri" ] && pri="($pri) "
local context="$(find_tags "${args[task]}" @)"
local project="$(find_tags "${args[task]}" +)"
local date="$(date +%F)"

local task="$pri$date $description $project $context"
echo "$task" >>$TASKMAGE_TODOFILE # write task to file
sort_file
local line="$(grep -n "$task" $TASKMAGE_TODOFILE)"
echo "Added task ${line%%:*} '$description'."
sed -E -i 's/[ \t]+$//' $TASKMAGE_TODOFILE # remove trailing whitespace
