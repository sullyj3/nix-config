function tag
    # warn if no files are given
    if test -z "$argv"
        echo "No files given"
        return
    end

    for f in $argv
        # determine file opener command to use based on file extension
        # could we use `open`? The problem is we need flags like `--loop` 
        # which are specific to the tagging workflow
        
        # we could use open as a fallback if we don't know how to open the file
        # we could have a flag to specify whether to use `open` for unknown files
        # or to skip them

        set -l comm echo "bug: command not set"
        if string match -e '.jpg' -- $f
            set comm feh -.
        else if string match -e '.mp4' -- $f
            set comm mpv --loop --mute
        else
            echo "Don't know how to open $f - skipping"
            continue
        end

        echo "Current tags:" (tmsu tags "$f")

        # open file in appropriate gui program in background
        # nohup ensures script can continue running concurrently
        nohup $comm "$f" > /dev/null 2>&1 &
        set -l gui_pid $last_pid

        # prompt user for tags to add
        echo "Enter tags to add. (leave blank to skip, 'q' to quit)"
        read -P "> " user_input
        if test -z "$user_input"
            continue
        else if string match "q" "$user_input"
            return
        end

        # add tags to file
        echo "tmsu tag --tags" \""$user_input"\" "$f"
        tmsu tag --tags "$user_input" "$f"

        # terminate the background process if it's still running
        # this could potentially close the wrong process if the OS has wrapped 
        # the PID space in the meantime, but it's unlikely
        if ps -p $gui_pid > /dev/null
            kill $gui_pid
        end

        # blank line for readability
        echo
    end
end
