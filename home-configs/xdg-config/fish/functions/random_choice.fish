# fish
function random_choice
    if test (count $argv) -eq 0
        echo "random_choice: no arguments provided" >&2
        return 1
    end
    echo $argv[(random 1 (count $argv))]
end
