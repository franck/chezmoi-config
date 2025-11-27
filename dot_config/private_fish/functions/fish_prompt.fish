function fish_prompt
  set -l last_status $status
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l green (set_color -o green)
  set -l normal (set_color normal)

  set -l ahead (_git_ahead)
  set -l whitespace ' '

  if test -f Pulumi.yaml
    # Cache Pulumi stack - invalidate when directory or Pulumi.yaml changes
    set -l cache_key (pwd):(stat -c %Y Pulumi.yaml 2>/dev/null || stat -f %m Pulumi.yaml 2>/dev/null)

    if test "$_pulumi_cache_key" != "$cache_key"
      set -g _pulumi_cache_key $cache_key
      set -g _pulumi_cache_stack (pulumi stack --show-name 2>/dev/null)
    end

    if test -n "$_pulumi_cache_stack"
      if string match -q "*prod*" "$_pulumi_cache_stack"
        set pulumi_info "$normal p:[$red$_pulumi_cache_stack$normal]"
      else
        set pulumi_info "$normal p:[$green$_pulumi_cache_stack$normal]"
      end
    end
  else
    # Clear cache when leaving Pulumi directory
    set -e _pulumi_cache_key
    set -e _pulumi_cache_stack
  end

  if test $last_status = 0
    set initial_indicator "$green◆"
    set status_indicator "$normal❯$cyan❯$green❯"
  else
    set initial_indicator "$red✖ $last_status"
    set status_indicator "$red❯$red❯$red❯"
  end
  set -l cwd $cyan(basename (prompt_pwd))

  if [ (_git_branch_name) ]

    set -l git_branch (_git_branch_name)
    if contains $git_branch master main
      set git_info "$normal g:($red$git_branch$normal)"
    else
      set git_info "$normal g:($blue$git_branch$normal)"
    end

    if [ (_is_git_dirty) ]
      set -l dirty "$yellow ✗"
      set git_info "$git_info$dirty"
    end
  end

  # Notify if a command took more than 5 minutes
  if [ "$CMD_DURATION" -gt 300000 ]
    echo The last command took (math "$CMD_DURATION/1000") seconds.
  end

  # echo -n -s $initial_indicator $whitespace $cwd $git_info $pulumi_info $whitespace $ahead $status_indicator $whitespace
  echo -n -s $initial_indicator $whitespace $cwd $git_info $pulumi_info $whitespace $ahead $status_indicator $whitespace
end

function _git_ahead
  set -l commits (command git rev-list --left-right '@{upstream}...HEAD' 2>/dev/null)
  if [ $status != 0 ]
    return
  end
  set -l behind (count (for arg in $commits; echo $arg; end | grep '^<'))
  set -l ahead  (count (for arg in $commits; echo $arg; end | grep -v '^<'))
  switch "$ahead $behind"
    case ''     # no upstream
    case '0 0'  # equal to upstream
      return
    case '* 0'  # ahead of upstream
      echo "$blue↑$normal_c$ahead$whitespace"
    case '0 *'  # behind upstream
      echo "$red↓$normal_c$behind$whitespace"
    case '*'    # diverged from upstream
      echo "$blue↑$normal$ahead $red↓$normal_c$behind$whitespace"
  end
end

function _git_branch_name
  echo (command git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  echo (command git status -s --ignore-submodules=dirty 2>/dev/null)
end
