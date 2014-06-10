
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="blinks"
ZSH_THEME="jreese"
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# per-directory-history
plugins=(extract git colored-man mosh sudo drush debian zsh-syntax-highlighting zaw ergoemacs-keybinds vagrant)
# singlechar systemadmin maybe
source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"
source ~/.commonrc


#fpath=(~/.oh-my-zsh/custom/ "${fpath[@]}")
#autoload -Uz insert-clipboard
#zle -N insert-clipboard
#bindkey '^Xu' insert-clipboard # pick a key combination you like...

globalias() {
   if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
     zle _expand_alias
     zle expand-word
   fi
   zle self-insert
}

zle -N globalias

bindkey " " globalias
bindkey "^ " magic-space           # control-space to bypass completion
bindkey -M isearch " " magic-space # normal space during searches

# Complete both files and commands at the same time.
_files_and_commands () {
    _files
    local ret=$?
    _command_names || return ret
}

# Always match files first and command names only if no files match.
compdef '_files || _command_names' -command-
#compdef '_files_and_commands' -command-


# completion for a couple of aliases
compdef rs=ssh
compdef os=ssh
compdef vs=ssh
compdef vp=ssh
compdef vu=ssh
compdef vd=ssh
compdef vr=ssh
compdef vh=ssh
compdef va=ssh


# Complete on empty line instead of inserting a tab.
# (The default is mainly for pasting indented snippets.)
zstyle ':completion:*' insert-tab false
zstyle ':completion:*:(vs|vp|vu|vd):*' hosts "${(f)$(</etc/vagrant_hosts)}"
