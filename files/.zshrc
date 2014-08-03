
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
plugins=(extract colored-man mosh sudo drush debian zsh-syntax-highlighting zaw ergoemacs-keybinds vagrant)
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

# Adapted from scmbreeze list_aliases.
list_keybinds () {
	bindkey | grep --color=always "$*" --color=never | awk -F " " '{ printf "\033[1;36m%15s  \033[2;37m=>\033[0m  %-8s\n",$1,$2}'
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
zstyle ':completion:*:(vs|vp|vu|vd|vh|va|vr):*' hosts "${(f)$(</etc/vagrant_hosts)}"
# Don't cache completion so new commands will be instantly available.
# https://unix.stackexchange.com/questions/2179/rebuild-auto-complete-index-or-whatever-its-called-and-binaries-in-path-cach
zstyle ":completion:*:commands" rehash 1

# realiaser config.
function last_command() {
  echo `history | tail -1 | cut -d ' ' -f 3-20 | realiaser`
}

RPROMPT='%{$fg[$NCOLOR]%}%p $(last_command)%{$reset_color%}'

# history
## Command history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=20000
SAVEHIST=20000

unsetopt append_history
setopt extended_history
unsetopt hist_expire_dups_first
unsetopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
# setopt share_history # share command history data
