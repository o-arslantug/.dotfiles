#!/bash

### HISTORY ###

# defines the history file, by default ~/.bash_history
export HISTFILE=~/.bash_profile_history

# controls how bash stores command history
#   ignorespace: flag will ignore commands that start with spaces
#   ignoredups: will ignore duplicates
#   ignoreboth will ignore both spaces and duplicates
export HISTCONTROL=ignorespace:ignoredups

# ignore the given commands which is below for history
export HISTIGNORE="ls*:cd*:history*:clear:exit"

# defines the number of lines of history to save in memory (by default 500)
export HISTSIZE=500

# defines the number of lines of history to save in the history file when the shell exits (by default 500)
export HISTFILESIZE=5000

# it is used as a strftime format string to display the time stamp associated with each displayed history entry
export HISTTIMEFORMAT="%T %F  |  "

# the history list is appended to the file named by the value of the HISTFILE variable when the shell exits
# rather than overwriting the file
shopt -s histappend

# bash checks the window size after each external (non-builtin) command
# if necessary, updates the values of LINES and COLUMNS
# this option is enabled by default
shopt -s checkwinsize

### HISTORY END ###

export PATH="/usr/local/sbin:$PATH"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

### BASH-COMPLETION ###

# Intel Mac Bash-Completion compatibility
[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# Apple Silicon Mac Bash-Completion compatibility
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

### BASH-COMPLETION END ###

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'ear
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Apple Silicon Mac Bash-Completion compatibility
if [ -f /opt/homebrew/bin/brew ]; then
  # Set PATH, MANPATH, etc., for Homebrew.
  eval "$(/opt/homebrew/bin/brew shellenv)"

  if type brew &>/dev/null; then
    HOMEBREW_PREFIX="$(brew --prefix)"
    if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
      source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    else
      for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
      do
        [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
      done
    fi
  fi
fi

# Intel Mac Bash-Completion compatibility
if [ -f /usr/local/bin/brew ]; then
  # Set PATH, MANPATH, etc., for Homebrew.
  eval "$(/usr/local/bin/brew shellenv)"

  if type brew &>/dev/null
  then
    HOMEBREW_PREFIX="$(brew --prefix)"
    if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
      source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
    else
      for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
      do
        [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
      done
    fi
  fi
fi