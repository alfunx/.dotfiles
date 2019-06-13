#########
#  FZF  #
#########

# auto-completion
[[ "$-" == *i* ]] \
    && source '/usr/share/fzf/completion.zsh' 2> /dev/null

# key bindings
[[ -f '/usr/share/fzf/key-bindings.zsh' ]] \
    && source '/usr/share/fzf/key-bindings.zsh'

# default options
export FZF_DEFAULT_OPTS='--height 30%
    --color fg:223,bg:235,hl:208,fg+:229,bg+:237,hl+:167,border:237
    --color info:246,prompt:214,pointer:214,marker:142,spinner:246,header:214'

export FZF_DEFAULT_COMMAND='fd -tf -HL 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd -td -HLI 2> /dev/null'
export FZF_TMUX=1
export FZF_TMUX_HEIGHT=30%
export FZF_COMPLETION_TRIGGER='**'

export FZF_CTRL_T_OPTS='--no-reverse'
export FZF_CTRL_R_OPTS='--no-reverse'
export FZF_ALT_C_OPTS='--no-reverse'
export FZF_COMPLETION_OPTS='--no-reverse'


###################
#  GIT heart FZF  #
###################
#
# See: https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236

is_in_git_repo() {
    git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
    fzf-tmux --height 50% "$@"
}

git-fzf-f() {
    is_in_git_repo || return
    git -c color.status=always status --short --no-branch \
        | fzf-down -m --ansi --nth 2..,.. --preview-window right:70% \
        --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' \
        | cut -c4- | sed 's/.* -> //'
}

git-fzf-b() {
    is_in_git_repo || return
    git branch -a --color=always | grep -v '/HEAD\s' | sort \
        | fzf-down --ansi --multi --tac --preview-window right:70% \
        --preview 'git lo --color=always $(sed s/^..// <<< {} | cut -d" " -f1) -- | head -'$LINES \
        | sed 's/^..//' | cut -d' ' -f1 | sed 's#^remotes/##'
}

git-fzf-t() {
    is_in_git_repo || return
    git tag --sort -version:refname \
        | fzf-down --multi --preview-window right:70% \
        --preview 'git show --color=always {} | head -'$LINES
}

git-fzf-h() {
    is_in_git_repo || return
    git lo --color=always \
        | fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
        --header 'Press CTRL-S to toggle sort' --preview-window right:50% \
        --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES \
        | grep -o "[a-f0-9]\{7,\}"
}

git-fzf-r() {
    is_in_git_repo || return
    git remote -v | awk '{print $1 "\t" $2}' | uniq \
        | fzf-down --tac --preview-window right:70% \
        --preview 'git lo --color=always {1} -- | head -200' \
        | cut -d$'\t' -f1
}

join-lines() {
    local item
    while read item; do
        echo -n "${(q)item} "
    done
}

bind-git-helper() {
    local c
    for c in "$@"; do
        eval "fzf-g$c-widget() { local result=\$(git-fzf-$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
        eval "zle -N fzf-g$c-widget"
        eval "bindkey '^g$c' fzf-g$c-widget"
    done
}
bind-git-helper f b t r h
unset -f bind-git-helper
