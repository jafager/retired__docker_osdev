umask 077

export PSPREPROMPT='\[\e[32m\]\h\[\e[0m\]:\[\e[37m\]$(~/local/bin/abbreviate_cwd)\[\e[0m\] \[\e[90m\]'
export PSPOSTPROMPT='\[\e[0m\]'
export PS1="${PSPREPROMPT}\\\$${PSPOSTPROMPT} "
export PS2="${PSPREPROMPT}>${PSPOSTPROMPT} "

export PATH=/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/local/bin:~/local/sbin

export EDITOR=vim
export VISUAL=$EDITOR
