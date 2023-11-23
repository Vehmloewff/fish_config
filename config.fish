# Analyst
function rocky
    ssh dev.emsianalyst.com
end

# Deno installs
set PATH "$HOME/.deno/bin:$PATH"

# C Stuff
set PATH "/opt/homebrew/opt/bison/bin:$PATH"
set PATH "/opt/homebrew/opt/make/libexec/gnubin:$PATH"
set PATH "/opt/homebrew/opt/libiconv/bin:$PATH"

# Don't display the normal fish stuff
set fish_greeting ""

# We'll do some things if we're running interactive
if status is-interactive
    # If there is a `tasks.fish` file in the current directory, load it
    if cat tasks.fish &>/dev/null
        source tasks.fish
    end
end

function ll
    ls -al --color=auto
end

function git_branch_raw
    git branch --show-current
end

function git_branch
    echo -n (git_branch_raw)

    if test (count (git status -s)) -gt 0
        echo -n "*"
    end

    # Idea was to add this info in, but it takes a moment because you have to go to the network
    #
    # if not git ls-remote --heads origin refs/heads/(git_branch_raw) &>/dev/null
    #     echo -n "unpublished"
    # end
end

function use_pwd
    pwd | sed "s#$HOME#~#"
end

function weather
    curl wttr.in/Moscow,+ID
end

function fish_prompt
    set -l last_command_status $status
    set arrow \uE0B0
    set dark 282c34
    set light ffffff
    set primary 2872c8

    set_color $light --background $primary
    echo -n " "
    echo -n (whoami)
    echo -n " "
    set_color normal

    set_color $primary --background $dark
    echo -n $arrow
    echo -n " "

    echo -n (use_pwd)

    if git status &>/dev/null
        echo -n " "
        echo -n "("
        echo -n (git_branch)
        echo -n ")"
    end

    if test $last_command_status != 0
        echo -n " "

        set_color red --background $dark
        echo -n "exit [$last_command_status]"
        set_color $primary --background $dark
    end

    echo -n " "
    set_color normal

    set_color $dark --background $primary
    echo -n $arrow
    set_color normal

    set_color $light --background $primary
    echo -n " Yes, Master? "
    set_color normal

    set_color $primary
    echo -n $arrow
    echo -n " "
    set_color normal
end
