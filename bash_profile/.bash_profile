#!/bash

## EXPORTS HOMEBREW VARIABLES AND SETS CONFIGURATIONS ##

if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

if [[ -n "$HOMEBREW_PREFIX" ]]; then
    if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
        . "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    fi

    if [ -f "${HOMEBREW_PREFIX}/etc/bash_completion.d/git-completion.bash" ]; then
        . "${HOMEBREW_PREFIX}/etc/bash_completion.d/git-completion.bash"
    fi

    if [ -f "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.bash" ]; then
        . "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.bash"
    fi
fi

## HISTORY ##

# controls how bash stores command history
#   ignorespace: flag will ignore commands that start with spaces
#   ignoredups: will ignore duplicates
#   ignoreboth will ignore both spaces and duplicates
export HISTCONTROL=ignorespace:ignoredups

# ignore the given commands which is below for history
export HISTIGNORE="ls*:cd*:history*:clear:exit"

# defines the number of lines of history to save in memory (by default 500)
export HISTSIZE=10000

# defines the number of lines of history to save in the history file when the shell exits (by default 500)
export HISTFILESIZE=50000

# it is used as a strftime format string to display the time stamp associated with each displayed history entry
export HISTTIMEFORMAT="%T %F  |  "

# the history list is appended to the file named by the value of the HISTFILE variable when the shell exits
# rather than overwriting the file
shopt -s histappend

# bash checks the window size after each external (non-builtin) command
# if necessary, updates the values of LINES and COLUMNS
# this option is enabled by default
shopt -s checkwinsize

## HISTORY END ##

export PATH="/usr/local/sbin:$PATH"

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# colorfull terminal #
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# ruby configuration
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"

export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig"

# python3 configuration
export PATH="$HOME/Library/Python/3.9/bin:$PATH"

alias lcc='php artisan route:clear && php artisan view:clear && php artisan config:clear && php artisan cache:clear && php artisan clear-compiled'