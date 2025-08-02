abbr -a yr 'cal -y'
abbr -a c cargo
abbr -a v vim
abbr -a m make
abbr -a g git
abbr -a pr 'gh pr create -t (git show -s --format=%s HEAD) -b (git show -s --format=%B HEAD | tail -n+3)'
abbr -a l 'ls'
abbr -a ll 'ls -l'
abbr -a lll 'ls -la'

# Fast open of common directories
abbr -a gen 'cd ~/Genesis'
abbr -a org 'vim ~/Genesis/org'
abbr -a probe 'vim ~/Genesis/probe'
abbr -a ufop 'vim ~/Genesis/ufop'
abbr -a dot 'vim ~/dotfiles'
abbr -a vimrc 'vim ~/.vimrc'
abbr -a ala 'vim ~/.config/alacritty/alacritty.toml'
abbr -a fc 'vim ~/.config/fish/config.fish'

abbr -a fz 'fzf --height 40% --reverse --inline-info' 


if test -f /usr/share/autojump/autojump.fish;
	source /usr/share/autojump/autojump.fish;
end

# Fish git prompt
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate ''
set __fish_git_prompt_showupstream 'none'
set -g fish_prompt_pwd_dir_length 3

# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

setenv FZF_DEFAULT_COMMAND 'fd --type file --follow'
setenv FZF_CTRL_T_COMMAND 'fd --type file --follow'
setenv FZF_DEFAULT_OPTS '--height 20%'

function fish_prompt
	set_color normal
	echo -n "["(date "+%H:%M")"] "
	set_color normal
    set_color normal
    echo -n ':'
    set_color normal
    echo -n $PWD
	set_color normal
	printf '%s ' (__fish_git_prompt)
	set_color normal
	echo -n '| '
	set_color normal
end

function fish_postexec
  echo "Exit status: " $status
end


# >>> conda initialize >>>
if test -f /opt/miniconda3/bin/conda
    eval /opt/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/opt/miniconda3/etc/fish/conf.d/conda.fish"
        . "/opt/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/opt/miniconda3/bin" $PATH
    end
end

