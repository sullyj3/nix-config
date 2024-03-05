# fish
function random_choice
    switch (count $argv)
    case 0
        echo "random_choice: no arguments provided" >&2
        return 1
    case 1
        # need to handle this case separately because `random` doesn't allow 
        # the endpoints to be equal
        echo $argv[1]
        return
    case '*'
        echo $argv[(random 1 (count $argv))]
    end
end
