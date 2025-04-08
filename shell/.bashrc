#!/bin/bash

# History management
export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTIGNORE="clear:bg:fg:cd:cd -:cd ..:exit:date:w:* --help:ls:l:ll:lll"

export SHELL=$(which fish)

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

