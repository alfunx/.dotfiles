#########
#  FZF  #
#########

# auto-completion
[[ $- == *i* ]] && source '/usr/share/fzf/completion.zsh' 2> /dev/null

# key bindings
source '/usr/share/fzf/key-bindings.zsh'

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

# Will return non-zero status if the current directory is not managed by git
is-in-git-repo() {
    git rev-parse HEAD > /dev/null 2>&1
}

fzf-git-tag() {
    # "Nothing to see here, move along"
    is-in-git-repo || return

    # Pass the list of the tags to fzf-tmux
    # - "{}" in preview option is the placeholder for the highlighted entry
    # - Preview window can display ANSI colors, so we enable --color=always
    # - We can terminate `git show` once we have $LINES lines
    git tag --sort -version:refname |
        fzf-tmux -d 70% --multi --preview-window right:70% \
                         --preview 'git show --color=always {} | head -'"$LINES"
}
zle         -N       fzf-git-tag
bindkey '^G^T' fzf-git-tag
