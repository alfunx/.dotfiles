##################
#  HIGHLIGHTING  #
##################

ZSH_HIGHLIGHT_HIGHLIGHTERS=(brackets main regexp pattern)

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=9,bold'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=11,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=13,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=13,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=13,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=12,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=14,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=14,underline'
ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
ZSH_HIGHLIGHT_STYLES[path]='underline'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='underline'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=9,bold'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=9,bold'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=208,bold'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=208,bold'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=208,bold'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='none'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='none'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=3'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=3'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=3'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=6'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=6'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=6'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=6'
ZSH_HIGHLIGHT_STYLES[assign]='fg=248'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=208'
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=208'
ZSH_HIGHLIGHT_STYLES[comment]='fg=8'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=14,bold'

typeset -A ZSH_HIGHLIGHT_PATTERNS
ZSH_HIGHLIGHT_PATTERNS+=('rm -f' 'fg=208,bold')
ZSH_HIGHLIGHT_PATTERNS+=('rm -r' 'fg=208,bold')
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf' 'fg=208,bold')
ZSH_HIGHLIGHT_PATTERNS+=('rm -fr' 'fg=208,bold')

typeset -A ZSH_HIGHLIGHT_REGEXP
ZSH_HIGHLIGHT_REGEXP+=()

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=1,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=15,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=15,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=15,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=15,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=15,bold'
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='fg=0,bg=208,bold'


#####################
#  AUTOSUGGESTIONS  #
#####################

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=241'
ZSH_AUTOSUGGEST_STRATEGY='match_prev_cmd'


############################
#  DISABLE FOR LONG INPUT  #
############################

ZSH_HIGHLIGHT_MAXLENGTH=200
