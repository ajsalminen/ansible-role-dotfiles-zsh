
function autopair5() {
    LBUFFER+="'"
    RBUFFER="'$RBUFFER"
}
zle -N autopair5 autopair5
bindkey "'" autopair5

function autopair6() {
    LBUFFER+="\""
    RBUFFER="\"$RBUFFER"
}
zle -N autopair6 autopair6
bindkey "\"" autopair6
