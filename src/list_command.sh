# shellcheck disable=SC2148 disable=SC2168 disable=SC2154
if [[ "${args[task_list]}" == 'archived' ]] || [[ "${args[task_list]}" == 'x' ]]; then
    local DATAFILE="$TASKMAGE_DONEFILE"
elif [[ "${args[task_list]}" == 'deleted' ]] || [[ "${args[task_list]}" == 'del' ]] ||
    [[ "${args[task_list]}" == 'removed' ]] || [[ "${args[task_list]}" == 'rm' ]]; then
    local DATAFILE="$TASKMAGE_DELETEDFILE"
elif [[ "${args[task_list]}" == 'all' ]] || [[ "${args[task_list]}" == 'all' ]]; then
    # TODO: add metadata specifying the origin of the file for each task
    cat "$TASKMAGE_TODOFILE" "$TASKMAGE_DONEFILE" "$TASKMAGE_DELETEDFILE" >/tmp/taskmage-all.txt
    local DATAFILE='/tmp/taskmage-all.txt'
else
    local DATAFILE="$TASKMAGE_TODOFILE"
fi

# get value of each field
local number_of_tasks="$(wc -l $DATAFILE)"
for ((i = 1; i <= "${number_of_tasks%% *}"; i++)); do
    local id=$i
    local task="$(sed -n "${i}p" $DATAFILE)"
    if [[ "$task" = x* ]]; then
        local completion_status='Complete'
    else
        local completion_status='Pending'
    fi
    local description="$(sed -E 's/^x //; s/^\([A-Z]\) //; s/^[0-9-]+ //; s/^[0-9-]+ //; s/ [+@][^ ]*//g; s/due:\S+//g; s/^[[:space:]]*//; s/[[:space:]]*$//' <<<"$task")"
    local pri="$(grep -oP '^\([A-Z]\)' <<<"$task" | sed 's/[()]//g')"
    local context="$(find_tags "$task" @)"
    local project="$(find_tags "$task" +)"
    local due_date="$(grep -oP 'due:\K[0-9]{4}-[0-9]{2}-[0-9]{2}' <<<"$task")"

    # find the completion and creation dates
    # this does a regex which matches only when the date is preceded by an x, a (letter) or another date
    local completion_creation="$(grep -oP '^x\s+(?:\([A-Z]\)\s+)?\d{4}-\d{2}-\d{2}(?:\s+\d{4}-\d{2}-\d{2})?|^(?:\([A-Z]\)\s+)\d{4}-\d{2}-\d{2}(?:\s+\d{4}-\d{2}-\d{2})?|^\d{4}-\d{2}-\d{2}(?=\s)' <<<"$task" | grep -oP '\d{4}-\d{2}-\d{2}')"

    # LOGIC:
    # if it has two dates, consider the first date to be completion date and the second date to be creation date
    # if it is pending and has one date, consider that to be creation date
    # if it is complete and has one date, consider that to be completion date
    local num_dates="$(wc -l <<<"$completion_creation")"
    if [[ "$num_dates" -eq 1 ]]; then
        [[ "$completion_status" == 'Pending' ]] && local creation_date="$completion_creation"
        [[ "$completion_status" == 'Complete' ]] && local completion_date="$completion_creation"
    elif [[ "$num_dates" -eq 2 ]]; then
        local completion_date="$(head -1 <<<"$completion_creation")"
        local creation_date="$(tail -1 <<<"$completion_creation")"
    fi

    local full_task+="$id\t$completion_status\t$pri\t$due_date\t$completion_date\t$creation_date\t$description\t$project\t$context\n"

    # this has to be unset before the next loop to prevent a bug where the next task has the same completion date as
    # the previous task if the next task only has one date
    unset completion_date
done

# print fields under respective headings
local n="$(tput sgr0)" # no formatting
local u="$(tput smul)" # underlined
local headings="${u}ID${n}\t${u}Status${n}\t${u}Priority${n}\t${u}Due${n}\t${u}Completed${n}\t${u}Created${n}\t${u}Description${n}\t${u}Projects${n}\t${u}Contexts${n}\t${u}${n}"
echo -e "$headings\n$full_task" | column -t -s $'\t'

# clean up if `all` was supplied (see top of file)
[ -f /tmp/taskmage-all.txt ] && rm /tmp/taskmage-all.txt
