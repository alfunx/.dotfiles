#########
#  FZF  #
#########

# auto-completion
[[ $- == *i* ]] && source '/usr/share/fzf/completion.bash' 2> /dev/null

# key bindings
[[ -f '/usr/share/fzf/key-bindings.bash' ]] && source '/usr/share/fzf/key-bindings.bash'

# default options
export FZF_DEFAULT_OPTS='--height 30%
    --color fg:223,bg:235,hl:208,fg+:229,bg+:237,hl+:167
    --color info:246,prompt:214,pointer:214,marker:142,spinner:246,header:214'

# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" 2> /dev/null'
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_DEFAULT_COMMAND='rg --files --hidden --follow 2> /dev/null'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow 2> /dev/null'
export FZF_TMUX=1
export FZF_TMUX_HEIGHT=30%
export FZF_COMPLETION_TRIGGER='**'

export FZF_CTRL_T_OPTS='--no-reverse'
export FZF_CTRL_R_OPTS='--no-reverse'
export FZF_ALT_C_OPTS='--no-reverse'
export FZF_COMPLETION_OPTS='--no-reverse'
