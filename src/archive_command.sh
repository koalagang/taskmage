# shellcheck disable=SC2148
# shellcheck disable=SC2168
# shellcheck disable=SC2154
grep '^x ' $TASKMAGE_TODOFILE >>$TASKMAGE_DONEFILE && sed -i '/^x /d' $TASKMAGE_TODOFILE
