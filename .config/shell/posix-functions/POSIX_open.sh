open() {
    command -v xdg-open > /dev/null && xdg-open "$@" && return
    [ "$(uname)" = "Darwin" ] && open "$@" && return
    [ "$(uname)" = "Haiku" ] && open "$@" && return
    echo "error: could not detect the open command for your system." && return 1
}
