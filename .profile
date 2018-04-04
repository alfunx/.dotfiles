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

# terminal emulator
export TERMINAL='kitty'

# editor
export VISUAL='vim'
export EDITOR='vim'

# ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"

# man / less colors
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;30m\e[48;5;208m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4;96m'
export LESS_TERMCAP_ue=$'\e[0m'
export MANROFFOPT='-c'
export LESS='-iMRj.3'

# # man / less colors (using tput)
# export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)
# export LESS_TERMCAP_md=$(tput bold; tput setaf 4)
# export LESS_TERMCAP_me=$(tput sgr0)
# export LESS_TERMCAP_so=$(tput bold; tput setaf 0; tput setab 11)
# export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# export LESS_TERMCAP_us=$(tput smul; tput setaf 14)
# export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
# export LESS_TERMCAP_mr=$(tput rev)
# export LESS_TERMCAP_mh=$(tput dim)
# export MANROFFOPT='-c'
# export LESS='-iMRj.3'

# gpg (for Github)
export GPG_TTY=$(tty)

# qt theme
export QT_QPA_PLATFORMTHEME="qt5ct"
