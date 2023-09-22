function pomo
    set -l subcmd $argv[1]
    if test -z $subcmd
        echo "No subcommand given!"
        return 1
    end
    set -l preset $argv[2]
    if test -z $preset
        set preset pomodoro
    end
    set -l protocol "tcp"

    comodoro $subcmd $preset $protocol
end
