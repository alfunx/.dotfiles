##################
#  HIGHLIGHTING  #
##################

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern regexp)

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=167,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=214,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=108,underline'
ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
ZSH_HIGHLIGHT_STYLES[path]='underline'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='none'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='none'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=66,bold'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=66,bold'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='none'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='none'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=172'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=172'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=172'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=72'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=72'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=72'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=72'
ZSH_HIGHLIGHT_STYLES[assign]='none'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=208'
ZSH_HIGHLIGHT_STYLES[comment]='fg=245'
ZSH_HIGHLIGHT_STYLES[alias]='fg=175,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=175,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=175,bold'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=108,bold'

typeset -A ZSH_HIGHLIGHT_PATTERNS
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf' 'fg=208,bold')

typeset -A ZSH_HIGHLIGHT_REGEXP
ZSH_HIGHLIGHT_REGEXP+=()


#####################
#  AUTOSUGGESTIONS  #
#####################

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=241'
ZSH_AUTOSUGGEST_STRATEGY='match_prev_cmd'
