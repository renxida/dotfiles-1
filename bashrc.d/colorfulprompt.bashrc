color_prompt=yes
export PROMPT_COMMAND=__prompt_command      # Func to gen PS1 after CMDs

HOSTNAME_HASH=$(sha1sum <<< "${HOSTNAME}")
HOSTNAME_HASH=${HOSTNAME_HASH%"${HOSTNAME_HASH#????????}"} # cut down to avoid int ovfl
HN_NUMBER=$((0x${HOSTNAME_HASH%% *}))
COLORIZED_HOSTNAME="\e[38;5;$(($HN_NUMBER % 231 + 1))m${HOSTNAME}"

function __prompt_command(){
    local EXIT="$?"
    if [ "$color_prompt" = yes ]; then
    PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[01;31m\]$EXIT\[\033[0;31m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@'${COLORIZED_HOSTNAME}; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@'${COLORIZED_HOSTNAME}; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"
else
    PS1='┌──[\u@\h]─[\w]\n└──╼ \$ '
fi
}


