# .bashrc

[ -z "$PS1" ] && return

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

unset GIT_PS1_SHOWUNTRACKEDFILES
unset GIT_PS1_SHOWUPSTREAM
unset GIT_PS1_SHOWDIRTYSTATE

if [ -f ~/bin/gitfiles/.git-completion.bash ]; then
    source ~/bin/gitfiles/.git-completion.bash
fi

if [ -f ~/bin/gitfiles/.git-prompt.sh ]; then
    source ~/bin/gitfiles/.git-prompt.sh
fi

RESET="\[\033[0m\]"

#export GIT_TRACE_PACKET=1

s0="\[\033[01;38;5;236m\]s"
k1="\[\033[01;38;5;238m\]k"
u2="\[\033[01;38;5;240m\]u"
m3="\[\033[01;38;5;242m\]m"
a4="\[\033[01;38;5;244m\]a"
r5="\[\033[01;38;5;246m\]r"
user="$s0$k1$u2$m3$a4$r5"

c6="\[\033[01;38;5;248m\]c"
a7="\[\033[01;38;5;249m\]a"
r8="\[\033[01;38;5;250m\]r"
l9="\[\033[01;38;5;251m\]l"
i10="\[\033[01;38;5;252m\]i"
t11="\[\033[01;38;5;253m\]t"
o12="\[\033[01;38;5;254m\]o"
host="$c6$a7$r8$l9$i10$t11$o12"

function _exit() {
    echo -e "Goodbye Soumya!"
}
trap _exit EXIT

function extract()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

PROMPT_COMMAND='__git_ps1 "\n[${user}@${host}${RESET}] \w\[\033[01;38;5;76m\]" "\n\[\033[01;38;5;219m\]\D{ %T}${RESET} ¶ "'

