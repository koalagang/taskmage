sort_file() {
    sort -ud $TASKMAGE_TODOFILE | awk '/^\(/ {print; next} {lines[++n]=$0} END {for(i=1; i<=n; i++) print lines[i]}' >/tmp/$TASKMAGE_TODOFILE
    mv /tmp/$TASKMAGE_TODOFILE $TASKMAGE_TODOFILE
}
