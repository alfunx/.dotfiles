###################
#  ENV VARIABLES  #
###################

# ruby
export PATH="$HOME/.gem/ruby/2.5.0/bin:$PATH"

# java
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"
export PATH="$JAVA_HOME/bin:$PATH"

# user scripts
export PATH="$HOME/.bin:$PATH"

# editor
export VISUAL='vim'
export EDITOR='vim'

# man page colors
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[0;30m\e[48;5;208m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;35m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS='-iMRj.5'

# gpg (for Github)
export GPG_TTY=$(tty)
