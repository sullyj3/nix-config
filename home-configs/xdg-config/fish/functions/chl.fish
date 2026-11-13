function chl
    pushd ~/tmp/claudes_office/
    claude --model haiku --effort low (string join ' ' -- $argv)
    popd
end
