function mdcd
    set -l dirpath $argv[1]
    mkdir $dirpath
    and cd $dirpath
end
