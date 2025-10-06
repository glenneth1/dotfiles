# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Enhanced History Configuration
# Don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth:erasedups

# Append to the history file, don't overwrite it
shopt -s histappend

# Much larger history - store 50,000 commands in memory and file
HISTSIZE=50000
HISTFILESIZE=50000

# Additional history options for better experience
# Save multi-line commands as single entries
shopt -s cmdhist

# Store history immediately (not just on shell exit)
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Ignore common commands to keep history cleaner
HISTIGNORE="ls:ll:la:cd:pwd:exit:clear:history"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

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
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

# Created by `pipx` on 2025-10-04 21:20:08
export PATH="$PATH:/home/glenn/.local/bin"

# Add NVIDIA utilities to PATH
export PATH="$PATH:/usr/lib/wsl/lib"

# Automatically added by the Guix install script.
# if [ -n "$GUIX_ENVIRONMENT" ]; then
#     if [[ $PS1 =~ (.*)"\\$" ]]; then
#         PS1="${BASH_REMATCH[1]} [env]\\$ "
#     fi
# fi

# Guix configuration
# Source Guix profile if it exists
# if [ -f "$HOME/.guix-profile/etc/profile" ]; then
#     . "$HOME/.guix-profile/etc/profile"
# fi

# Guix locale configuration
# export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"

# Fix locale issues - unset problematic LC_ALL and use working locale
unset LC_ALL
export LANG="C.utf8"
export LC_CTYPE="C.utf8"

# Initialize Starship prompt
eval "$(starship init bash)"

# ---- Git Delta Configuration ----
# Enhanced git diff viewing (git-delta should be installed)
# Configuration is handled in ~/.gitconfig, but we can add useful aliases
if command -v delta >/dev/null 2>&1; then
    # Git aliases for better diff viewing
    alias gdiff='git diff'
    alias glog='git log --oneline --graph --decorate --all'
    alias gshow='git show'
fi

# ---- Bat Configuration (better cat) ----
if command -v batcat >/dev/null 2>&1; then
    export BAT_THEME="tokyonight_night"
    alias bat="batcat"
    alias cat="batcat"
elif command -v bat >/dev/null 2>&1; then
    export BAT_THEME="tokyonight_night"
    alias cat="bat"
fi

# ---- FZF Configuration ----
if command -v fzf >/dev/null 2>&1; then
    # Set up fzf key bindings and fuzzy completion for bash
    eval "$(fzf --bash)"
    
    # Use fd instead of find for fzf (Ubuntu uses fdfind)
    if command -v fdfind >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND="fdfind --hidden --strip-cwd-prefix --exclude .git"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="fdfind --type=d --hidden --strip-cwd-prefix --exclude .git"
    fi
    
    # Setup fzf theme (tokyo-night inspired)
    fg="#CBE0F0"
    bg="#011628"
    bg_highlight="#143652"
    purple="#B388FF"
    blue="#06BCE4"
    cyan="#2CF9ED"
    
    export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"
    
    # Enhanced fzf previews
    if command -v batcat >/dev/null 2>&1; then
        export FZF_CTRL_T_OPTS="--preview 'if [ -d {} ]; then ls -la {}; else batcat -n --color=always --line-range :500 {}; fi'"
    else
        export FZF_CTRL_T_OPTS="--preview 'if [ -d {} ]; then ls -la {}; else head -500 {}; fi'"
    fi
fi

# ---- fd-find Configuration ----
if command -v fdfind >/dev/null 2>&1; then
    # Ubuntu packages fd as fdfind
    alias fd="fdfind"
    alias find="fdfind"  # Replace find with fd for better performance
fi

# ---- Enhanced ls with eza ----
if command -v eza >/dev/null 2>&1; then
    # Better ls defaults with eza
    alias ls='eza --group-directories-first --icons'
    alias ll="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
    alias la="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --all"
    alias lt="eza --tree --color=always --icons=always"
else
    # Fallback to regular ls with color
    alias ls='ls --color=auto'
fi

# ---- Zoxide Configuration (better cd) ----
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
    alias cd="z"  # Replace cd with zoxide for smart directory jumping
fi

# ---- Useful Development Aliases ----
# SBCL with rlwrap history (if rlwrap is available)
if command -v rlwrap >/dev/null 2>&1 && command -v sbcl >/dev/null 2>&1; then
    alias sbcl='rlwrap -H ~/.sbcl_history sbcl'
fi

# Guile with rlwrap history (if rlwrap is available)
if command -v rlwrap >/dev/null 2>&1 && command -v guile >/dev/null 2>&1; then
    alias guile='rlwrap -H ~/.guile_history guile'
fi

# Clean Windows Zone.Identifier files (useful for WSL)
alias delete_junk_files='find . -name "*:Zone.Identifier" -type f -delete'

# ---- FZF-Git Integration ----
# Enhanced git workflows with fzf
if [ -f ~/fzf-git.sh/fzf-git.sh ]; then
    source ~/fzf-git.sh/fzf-git.sh
fi
