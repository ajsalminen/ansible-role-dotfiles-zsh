function precmd {
printf '\e[1;34m%*s\e[0m\n' "${COLUMNS:-\$(tput cols)}" '' | tr ' ' _
}
