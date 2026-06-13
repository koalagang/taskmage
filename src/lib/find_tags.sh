find_tags() {
    # $1 is the task
    # $2 can be @ or +
    local prefix="$2"
    grep -oP "[$prefix]\w+" <<<"$1" | grep -v "^[$prefix]x$" | tr '\n' ' '
}
