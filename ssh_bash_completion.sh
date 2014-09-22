#on osx, I go in /usr/local/etc/bash_completion/ssh
_ssh() 
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="`grep "Host " ~/.ssh/config|grep -v "\*"|cut -f2 -d' '`"
    #opts="a b c"

    if [[ ${cur} == * ]] ; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    fi
}
complete -F _ssh ssh

