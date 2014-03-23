# Adapted from https://github.com/rsuhada/.oh-my-zsh
function autopair_singlequotes() {
    LBUFFER+="'"
    RBUFFER="'$RBUFFER"
}
zle -N autopair_singlequotes autopair_singlequotes
bindkey "'" autopair_singlequotes

function autopair_doublequotes() {
    LBUFFER+="\""
    RBUFFER="\"$RBUFFER"
}
zle -N autopair_doublequotes autopair_doublequotes
bindkey "\"" autopair_doublequotes
