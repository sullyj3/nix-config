# Defined via `source`
function mkcd
    set -l dir $argv[1]
    if not test -d $dir
        echo "creating directory $dir"
        mkdir $dir
    end
    cd $dir
end
