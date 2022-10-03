function check_network
    set -l router (ip r | grep default | cut -d ' ' -f 3)
    test -n "$router"; and ping -q -w 1 -c 1 $router > /dev/null
end
