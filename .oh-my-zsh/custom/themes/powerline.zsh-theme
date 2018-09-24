# vim:ft=zsh ts=4 sw=4 sts=4
#
# A Powerline-inspired theme for ZSH
# based on: agnoster's Theme - https://gist.github.com/3712874

### Variables (default: Gruvbox)
# Background
local PROMPT_0_BG=${PROMPT_0_BG:=250}
local PROMPT_1_BG=${PROMPT_1_BG:=246}
local PROMPT_2_BG=${PROMPT_2_BG:=239}
local PROMPT_3_BG=${PROMPT_3_BG:=237}
# Foreground
local PROMPT_0_FG=${PROMPT_0_FG:=0}
local PROMPT_1_FG=${PROMPT_1_FG:=235}
local PROMPT_2_FG=${PROMPT_2_FG:=248}
local PROMPT_3_FG_CLEAN=${PROMPT_3_FG_CLEAN:=10}
local PROMPT_3_FG_DIRTY=${PROMPT_3_FG_DIRTY:=11}
local PROMPT_3_FG_ERROR=${PROMPT_3_FG_ERROR:=9}

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'

# Special Powerline characters

() {
    local LC_ALL='' LC_CTYPE='en_US.UTF-8'

    # NOTE: This segment separator character is correct.  In 2012, Powerline changed
    # the code points they use for their special characters. This is the new code point.
    # If this is not working for you, you probably have an old version of the
    # Powerline-patched fonts installed. Download and install the new version.
    # Do not submit PRs to change this unless you have reviewed the Powerline code point
    # history and have new information.
    # This is defined using a Unicode escape sequence so it is unambiguously readable, regardless of
    # what font the user is viewing this source code in. Do not replace the
    # escape sequence with a single literal character.
    # Do not change this! Do not make it '\u2b80'; that is the old, wrong code point.

    SEGMENT_SEPARATOR=$'\ue0b0'  # 
    # SEGMENT_SEPARATOR=$'\u258c'  # ▌
    SEGMENT_SEPARATOR2=$'\ue0b1'  # 
    # SEGMENT_SEPARATOR2=$'\u2502'  # │
}

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
    local bg fg
    [[ -n $1 ]] && bg="%K{$1}" || bg='%k'
    [[ -n $2 ]] && fg="%F{$2}" || fg='%f'
    if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
        echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
    else
        echo -n "%{$bg%}%{$fg%} "
    fi
    CURRENT_BG=$1
    [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
    if [[ -n $CURRENT_BG ]]; then
        echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
    else
        echo -n '%{%k%}'
    fi
    echo -n '%{%f%}'
    CURRENT_BG=''
}

# Helper function to read the first line of a file into a variable
# Takes two arguments, file path and variable name
git_eread() {
	test -r "$1" && IFS=$'\r\n' read "$2" <"$1"
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
    if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
        prompt_segment "${PROMPT_1_BG}" "${PROMPT_1_FG}" '%(!.%{%F{11}%}.)%n@%M'
    fi
}

# Git: branch/detached head, dirty status
prompt_git() {
    (( $+commands[git] )) || return
    local PL_BRANCH_CHAR
    () {
        local LC_ALL='' LC_CTYPE='en_US.UTF-8'
        PL_BRANCH_CHAR=$'\ue0a0'  # 
    }
    local ref dirty repo_path
    repo_path=$(git rev-parse --git-dir 2>/dev/null)

    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
        dirty=$(parse_git_dirty)
        ref=$(git symbolic-ref HEAD 2> /dev/null) \
            || ref="⤷ $(git rev-parse --short HEAD 2> /dev/null)"

        if [ -e "${repo_path}/rebase" \
            || -e "${repo_path}/rebase-merge" \
            || -e "${repo_path}/rebase-apply" \
            || -e "${repo_path}/MERGE_HEAD" \
            || -e "${repo_path}/CHERRY_PICK_HEAD" \
            || -e "${repo_path}/REVERT_HEAD" \
            || -e "${repo_path}/BISECT_LOG" \
            || -e "${repo_path}/../.dotest" ]; then
            prompt_segment "${PROMPT_3_BG}" "${PROMPT_3_FG_ERROR}"
        elif [ -n $dirty ]; then
            prompt_segment "${PROMPT_3_BG}" "${PROMPT_3_FG_DIRTY}"
        else
            prompt_segment "${PROMPT_3_BG}" "${PROMPT_3_FG_CLEAN}"
        fi

        local mode step total
        if [ -d "${repo_path}/rebase-merge" ]; then
            git_eread "${repo_path}/rebase-merge/msgnum" step
            git_eread "${repo_path}/rebase-merge/end" total
            if [ -f "${repo_path}/rebase-merge/interactive" ]; then
                mode+="Ri"
            else
                mode+="Rm"
            fi
        else
            if [ -d "${repo_path}/rebase-apply" ]; then
                git_eread "${repo_path}/rebase-apply/next" step
                git_eread "${repo_path}/rebase-apply/last" total
                if [ -f "${repo_path}/rebase-apply/rebasing" ]; then
                    mode+="R"
                elif [ -f "${repo_path}/rebase-apply/applying" ]; then
                    mode+="AM"
                else
                    mode+="R/AM"
                fi
            elif [ -f "${repo_path}/MERGE_HEAD" ]; then
                mode+="M"
            elif [ -f "${repo_path}/CHERRY_PICK_HEAD" ]; then
                mode+="C"
            elif [ -f "${repo_path}/REVERT_HEAD" ]; then
                mode+="REV"
            elif [ -f "${repo_path}/BISECT_LOG" ]; then
                mode+="B"
            fi
        fi
        if [ -n "$step" ] && [ -n "$total" ]; then
            mode+=" ($step/$total)"
        fi
        if [ -n "$mode" ]; then
            mode=" $SEGMENT_SEPARATOR2 $mode"
        fi

        setopt promptsubst
        autoload -Uz vcs_info

        zstyle ':vcs_info:*' enable git
        zstyle ':vcs_info:*' get-revision true
        zstyle ':vcs_info:*' check-for-changes true
        zstyle ':vcs_info:*' stagedstr '●'
        zstyle ':vcs_info:*' unstagedstr '○'
        zstyle ':vcs_info:*' formats ' %u%c'
        zstyle ':vcs_info:*' actionformats ' %u%c'
        zstyle ':vcs_info:git:*' patch-format '(%n/%a)'
        zstyle ':vcs_info:git:*' nopatch-format '(%n/%a)'
        vcs_info
        echo -n "${ref/refs\/heads\//$PL_BRANCH_CHAR }${vcs_info_msg_0_%% }${mode}"
    fi
}

prompt_bzr() {
    (( $+commands[bzr] )) || return
    if (bzr status >/dev/null 2>&1); then
        status_mod=`bzr status | head -n1 | grep 'modified' | wc -m`
        status_all=`bzr status | head -n1 | wc -m`
        revision=`bzr log | head -n2 | tail -n1 | sed 's/^revno: //'`
        if [[ $status_mod -gt 0 ]] ; then
            prompt_segment "${PROMPT_3_BG}" "${PROMPT_3_FG_DIRTY}"
            echo -n "bzr@"$revision "✚ "
        else
            if [[ $status_all -gt 0 ]] ; then
                prompt_segment "${PROMPT_3_BG}" "${PROMPT_3_FG_DIRTY}"
                echo -n "bzr@"$revision

            else
                prompt_segment "${PROMPT_3_BG}" "${PROMPT_3_FG_CLEAN}"
                echo -n "bzr@"$revision
            fi
        fi
    fi
}

prompt_hg() {
    (( $+commands[hg] )) || return
    local rev status
    if $(hg id >/dev/null 2>&1); then
        if $(hg prompt >/dev/null 2>&1); then
            if [[ $(hg prompt "{status|unknown}") = "?" ]]; then
                # if files are not added
                prompt_segment "${PROMPT_3_BG}" "${PROMPT_3_FG_ERROR}"
                st='±'
            elif [[ -n $(hg prompt "{status|modified}") ]]; then
                # if any modification
                prompt_segment "${PROMPT_3_BG}" "${PROMPT_3_FG_DIRTY}"
                st='±'
            else
                # if working copy is clean
                prompt_segment "${PROMPT_3_BG}" "${PROMPT_3_FG_CLEAN}"
            fi
            echo -n $(hg prompt "☿ {rev}@{branch}") $st
        else
            st=""
            rev=$(hg id -n 2>/dev/null | sed 's/[^-0-9]//g')
            branch=$(hg id -b 2>/dev/null)
            if `hg st | grep -q "^\?"`; then
                prompt_segment "${PROMPT_3_BG}" "${PROMPT_3_FG_ERROR}"
                st='±'
            elif `hg st | grep -q "^[MA]"`; then
                prompt_segment "${PROMPT_3_BG}" "${PROMPT_3_FG_DIRTY}"
                st='±'
            else
                prompt_segment "${PROMPT_3_BG}" "${PROMPT_3_FG_CLEAN}"
            fi
            echo -n "☿ $rev@$branch" $st
        fi
    fi
}

prompt_svn() {
    local rev branch
    if $(in_svn > /dev/null 2>&1); then
        rev=$(svn_get_rev_nr)
        branch=$(svn_get_branch_name)
        PL_BRANCH_CHAR=$'\ue0a0'                 # 
        if [[ $(svn_dirty_choose_pwd 1 0) -eq 1 ]]; then
            prompt_segment "${PROMPT_3_BG}" "${PROMPT_3_FG_DIRTY}"
            echo -n "$PL_BRANCH_CHAR $rev@$branch"
            echo -n '±'
        else
            prompt_segment "${PROMPT_3_BG}" "${PROMPT_3_FG_CLEAN}"
            echo -n "$PL_BRANCH_CHAR $rev@$branch"
        fi
    fi
}

# Dir: current working directory
prompt_dir() {
    prompt_segment "${PROMPT_2_BG}" "${PROMPT_2_FG}" '%(5~|%-1~/…/%3~|%4~)'
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
    local virtualenv_path="$VIRTUAL_ENV"
    if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
        prompt_segment "${PROMPT_2_BG}" "${PROMPT_2_FG}" "(`basename $virtualenv_path`)"
    fi
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
    local symbols
    symbols=()
    [[ $RETVAL -ne 0 ]] && symbols+='%{%F{124}%}✘%?'
    [[ $UID -eq 0 ]] && symbols+='%{%F{172}%}⚡'
    [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+='%{%F{72}%}⚙%j'

    [[ -n "$symbols" ]] && prompt_segment "${PROMPT_0_BG}" "${PROMPT_0_FG}" "$symbols"
}

## Main prompt
build_prompt() {
    RETVAL=$?
    prompt_status
    prompt_virtualenv
    prompt_context
    prompt_dir
    prompt_git
    prompt_bzr
    prompt_hg
    prompt_svn
    prompt_end
}

## Secondary prompt
build_prompt2() {
    prompt_segment "${PROMPT_2_BG}" "${PROMPT_2_FG}" '%(1_.%_ .)…'
    prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '
PROMPT2='$(build_prompt2) '
MODE_INDICATOR="%{$fg[red]%}██%{$reset_color%}"
