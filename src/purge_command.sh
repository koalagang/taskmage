# shellcheck disable=SC2148 disable=SC2168 disable=SC2154
local task="$(sed -n "${args[task_id]}p" $TASKMAGE_DELETEDFILE)"
local description="$(sed -E 's/^x //; s/^\([A-Z]\) //; s/^[0-9-]+ //; s/^[0-9-]+ //; s/ [+@].*//' <<<"$task")"
sed -i "${args[task_id]}d" $TASKMAGE_DELETEDFILE
echo "Purged task $1 '$description'."
