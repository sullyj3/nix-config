function pacwhy
    pacman -Qi $argv[1] | rg "Name|Required By|Depends On|Install Reason"
end
