function tmux_start_processes
    # Default session name
    set SESSION_NAME "tmux_start_processes"

    # Create an empty list for commands
    set -l commands

    # Parse arguments
    for arg in $argv
        switch $arg
            case -s
                set SESSION_NAME_NEXT true
            case '*'
                if set -q SESSION_NAME_NEXT
                    set SESSION_NAME $arg
                    set -e SESSION_NAME_NEXT
                else
                    set commands $commands $arg
                end
        end
    end

    # Check if at least one command is provided
    if test (count $commands) -eq 0
        echo "Please provide at least one command."
        return 1
    end

    # Check if the tmux session already exists
    if tmux has-session -t $SESSION_NAME 2>/dev/null
        echo "Session $SESSION_NAME already exists. Attaching to it."
        tmux attach-session -t $SESSION_NAME
        return 0
    end

    # Start the first process in a new tmux session
    tmux new-session -d -s $SESSION_NAME "fish -C \"$commands[1]\""

    # Start the other processes in new panes
    for i in (seq 2 (count $commands))
        tmux split-window -h "fish -C \"$commands[$i]\""
        tmux select-layout even-vertical
    end

    # Attach to the tmux session
    tmux attach-session -t $SESSION_NAME
end
