function open
    if command -v xdg-open > /dev/null
        xdg-open $argv
        return
    end

    if test (uname) = "Darwin"
        command open $argv
        return
    end

    if test (uname) = "Haiku"
        command open $argv
        return
    end

    echo "error: could not detect the open command for your system."
    return 1
end
