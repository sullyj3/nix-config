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


        # open file in appropriate gui program in background
        # nohup ensures script can continue running concurrently
        nohup $comm "$f" > /dev/null 2>&1 &
        set -l gui_pid $last_pid


        # prompt user for tags to add
        set -l choices_tmp (mktemp)
        tmsu tags | cat - (echo 'q'| psub) > $choices_tmp

        set -l current_tags (tmsu tags --name never "$f")

        # todo maybe the filename and current tags should go in the preview. Can we get colors there?
        set -l user_input (fzf --multi --bind 'tab:toggle+end-of-line+unix-line-discard' \
            --preview 'cat {+f}' \
            --header='File: '$f\n'Current tags: '"$current_tags"\n"Enter tags to add (leave blank to skip, 'q' to quit)" \
            < $choices_tmp)
        command rm $choices_tmp

        # this boolean flag nonsense is necessary to avoid duplicating the 
        # process termination stanza, because fish doesn't have locally scoped
        # functions and I don't want to pollute the global namespace
        # https://github.com/fish-shell/fish-shell/issues/1799
        set -l should_exit 0
        if string match "q" "$user_input"
            set should_exit 1
        else if test -z "$user_input"
            # If no input, skip this file
        else
            # add tags to file
            echo "tmsu tag --tags" \""$user_input"\" "$f"
            tmsu tag --tags "$user_input" "$f"
        end

        # terminate the background process if it's still running
        # this could potentially close the wrong process if the OS has wrapped 
        # the PID space in the meantime, but it's unlikely
        if ps -p $gui_pid > /dev/null
            kill $gui_pid
        end

        if test $should_exit -eq 1
            return
        end

        # blank line for readability
        echo
    end
end
