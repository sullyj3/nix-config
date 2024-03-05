function up
    set -l temp (mktemp)
    goup $temp $argv
    set -l result $status

    if test $result -eq 0
        read -l target_dir < $temp
        cd $target_dir
    end

    command rm $temp
    return $result
end
