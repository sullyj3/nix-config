function addjust
    if test (count $argv) -ne 2
        echo "Usage: addjust <alias> <command>"
        return 1
    end

    set -l alias $argv[1]
    set -l cmd $argv[2]
    printf "$alias:\n\t$cmd" | read -z str

    # check if there's an existing Justfile
    # is there a better way to do this case-insensitivity?
    if test -f justfile
        set -f justfile "justfile"
    else if test -f Justfile
        set -f justfile "Justfile"
    else
        touch justfile
        set -f justfile "justfile"
    end

    # if it's non-empty, add a newline to separate the new addition
    # from existing contents
    if test -s $justfile
        echo >> $justfile
    end

    echo $str >> $justfile
    cat $justfile
end
