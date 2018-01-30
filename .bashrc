############
#  BASHRC  #
############

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

eval "$(dircolors "$HOME"/.dir_colors)"

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

PS1='[\[\033[1;31m\]\u\[\033[0m\]@\H \w]$ '

# Export
source "$HOME/.env.sh"

# FZF
if [ -f "$HOME/.fzf.bash" ]; then
  source "$HOME/.fzf.bash"
fi
