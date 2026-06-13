# shellcheck disable=SC2148 disable=SC2168 disable=SC2154
local task="$(sed -n "${args[task_id]}p" $TASKMAGE_TODOFILE)"
[[ "$task" = x* ]] && echo 'taskmage: error: task already completed' && exit 1
local description="$(sed -E 's/^x //; s/^\([A-Z]\) //; s/^[0-9-]+ //; s/^[0-9-]+ //; s/ [+@].*//' <<<"$task")"

local completion_date="$(date +%F)"
local completed_task="$(sed "s/^(\([A-Z]\))\(.*\)/x (\1) $completion_date\2/; t; s/^/x $completion_date /" <<<"$task")"

sed -i "${1}s/$task/$completed_task/" $TASKMAGE_TODOFILE
echo "Completed task ${args[task_id]} '$description'."

sort_file
