# shellcheck disable=SC2148 disable=SC2168 disable=SC2154
local task="$(sed -n "${args[task_id]}p" $TASKMAGE_TODOFILE)"
local description="$(sed -E 's/^x //; s/^\([A-Z]\) //; s/^[0-9-]+ //; s/^[0-9-]+ //; s/ [+@].*//' <<<"$task")"
echo "$task" >>$TASKMAGE_DELETEDFILE
sed -i "${args[task_id]}d" $TASKMAGE_TODOFILE
echo "Deleted task ${args[task_id]} '$description'."
