function up
    echo "Enter number to navigate up to that directory"

    # Start with the parent of the current directory
    set -l current_dir (dirname (pwd))
    set -l dirs $current_dir

    # Collect parent directories up to the root
    while test "$current_dir" != "/"
        set current_dir (dirname "$current_dir")
        set -a dirs $current_dir
    end

    # Display directories with numbers
    set -l dir_count (count $dirs)
    for i in (seq 1 $dir_count)
        echo "$i: $dirs[$i]"
    end

    # Prompt user for input
    read -l choice

    # Validate input
    # just return if they didn't enter anything
    if test -z $choice
        echo "Staying in the current directory."
        return
    end

    if not string match -qr '^[0-9]+$' -- $choice
        echo "Must enter a number. Staying in the current directory."
        return
    end

    set -l numeric_choice (math $choice)
    if test $numeric_choice -le 0 -o $numeric_choice -gt $dir_count
        echo "Number must be between 1 and $dir_count. Staying in the current directory."
        return
    end

    # Navigate to chosen directory
    set -l target_dir $dirs[$numeric_choice]
    echo "Navigating to $target_dir"
    cd "$target_dir"
end
