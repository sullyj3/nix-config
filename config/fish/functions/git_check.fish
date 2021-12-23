# shamelessly stolen from 
# https://github.com/quintrino/dotfiles/blob/30c7007661947f0b32a79d7d6981afb175d747dc/shell/fish/config#L22
function git_check
  # ensure directory is a git repo
  git -C $argv[1] rev-parse 2>/dev/null
  if test $status -eq 128
    echo "$argv[1] does not exist or is not a git repository"
    return 128
  end
  set starting_directory (pwd)

  cd $argv[1]

  git fetch --quiet >/dev/null & disown
  begin
    # check for changes
    git diff --quiet --ignore-submodules HEAD

    # check for untracked, non ignored files
    and git ls-files --other --directory --exclude-standard | sed -n q1
  end
  or echo "WARNING: $argv[2] has unsynchronized changes"

  cd $starting_directory
end
