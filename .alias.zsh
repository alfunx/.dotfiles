#############
#  aliases  #
#############

compdef dotfiles=git

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../.././...'

alias :q='exit'

alias cp='cp --reflink=auto -i'

alias pg='ping -c 1 www.google.ch'

alias bcl='bc -l'

alias neofetch='echo "\\n\\n" && neofetch'

foreground-job() {
  fg
}
zle     -N   foreground-job
bindkey '^Z' foreground-job

con() {
  cmd=$1
  shift

  case "$cmd" in
    vim)
      vim ~/.vimrc "$@" ;;
    tmux)
      vim ~/.tmux.conf "$@" ;;
    git)
      vim ~/.gitconfig ~/.gitignore ~/.gitmodules "$@" ;;
    zsh)
      vim ~/.zshrc ~/.zsh_aliases ~/.oh-my-zsh/themes/agnoster-custom.zsh-theme "$@" ;;
    bash)
      vim ~/.bashrc ~/.bash_profile "$@" ;;
    aw)
      vim ~/.config/awesome/rc.lua ~/.config/awesome/themes/powerarrow-gruvbox/theme.lua "$@" ;;
    xorg)
      vim ~/.xinitrc "$@" ;;
    script)
      vim ~/scripts/* "$@" ;;
    *)
      vim ~/.zsh_aliases "$@" ;;
  esac
}

mkcd() {
  [ $# -gt 1 ] && exit 1
  mkdir -p "$1" && cd "$1" || exit 1
}

toilol() {
  toilet -f mono12 -w "$(tput cols)" | lolcat "$@"
}

pacman() {
  local pattern="^-S[cuy]|^-S$|^-R[sn]|^-R$|^-U$|^-F[y]"
  if [[ "$1" =~ $pattern ]]; then
    sudo /usr/bin/pacman "$@"
  else
    /usr/bin/pacman "$@"
  fi

  # Update pacman widget
  dbus-send --dest=org.awesomewm.awful --type=method_call \
    / org.awesomewm.awful.Remote.Eval \
    string:'pacman = require("beautiful").pacman; if pacman then pacman.update() end'
}

officer() {
  local pattern="^-S[cuy]|^-S$|^-R[sn]|^-R$|^-U"
  if [[ "$1" =~ $pattern ]]; then
    sudo /usr/bin/officer "$@"
  else
    /usr/bin/officer "$@"
  fi
}
compdef officer=pacman

pacman-date-log() {
  { pacman "${1:--Qeq}"; cat /var/log/pacman.log; } | awk '
    NF == 1 { pkgs[$0] = 1; }
    $4 == "installed" {
      if ($5 in pkgs) { pkgs[$5] = $1 " " $2; }
    }
    END {
      for (p in pkgs) { print pkgs[p], p; }
    }' | sort
}

tmux() {
  if [ "$1" = '.' ]; then
    if [ -f ./.tmux ]; then
      read -r -k 1 "reply?$fg_bold[white]Source $fg_bold[red]$(dirs)/.tmux$fg_bold[white]? [y/N] $reset_color"
      echo
      if [[ $reply =~ ^[Yy]$ ]]; then
        if [[ ! -z "$TMUX" ]]; then
          tmux source-file "$(pwd)/.tmux"
        else
          echo "No tmux session attached."; return 1
        fi
      else
        echo "Not sourced .tmux file."; return 0
      fi
    else
      echo "No .tmux file found."; return 1
    fi
  elif [ "$TERM" = "linux" ]; then
    /usr/bin/tmux -L linux -f "$HOME/.tmux.minimal.conf" "$@"
  else
    /usr/bin/tmux "$@"
  fi
}

#########
#  fzf  #
#########

alias fzf="fzf-tmux -d 30%"

#############
#  ripgrep  #
#############

# fuzzy rg
frg() {
  rg --line-number --column --no-heading --color=always --colors='match:none' --colors='path:fg:white' --colors='line:fg:white' "$@" . 2> /dev/null | fzf --ansi
}

#######################
# the silver searcher #
#######################

alias ag="ag --hidden --follow --smart-case --numbers --color-match '1;31' --color-path '0;37' --color-line-number '1;33'"

# fuzzy ag
fag() {
  ag --nobreak --noheading --color --color-match '' --color-path '0;37' --color-line-number '0;37' "$@" . 2> /dev/null | fzf --ansi
}

##################
# fuzzy commands #
##################

# # fda - cd to selected directory
# fda() {
#   cd "$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2>/dev/null \
#     | fzf +m -q "$1" -0)"
# }

# fda - cd to selected directory
fda() {
  cd "$(fd --follow --type d '.' "${1:-.}" 2>/dev/null \
    | fzf +m -q "$1" -0)" || exit 1
}

# # c - fda including hidden directories
# c() {
#   cd "$(find -L ${1:-.} -type d 2>/dev/null \
#     | fzf +m -q "$1" -0)"
# }

# c - fda including hidden directories
c() {
  cd "$(fd --hidden --follow --type d '.' "${1:-.}" 2>/dev/null \
    | fzf +m -q "$1" -0)" || exit 1
}

# # fr - cd to selected directory and open ranger
# fr() {
#   cd "$(find -L ${1:-.} -type d 2>/dev/null \
#     | fzf +m -q "$1" -0)" && ranger
# }

# fr - cd to selected directory and open ranger
fr() {
  cd "$(fd --hidden --follow --type d '.' "${1:-.}" 2>/dev/null \
    | fzf +m -q "$1" -0)" && ranger
}

# fo - Open the selected file with the default editor
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  local out file key
  IFS=$'\n' out=($(fzf -q "$1" -0 --expect=ctrl-o,ctrl-e))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && mimeopen -n "$file" || ${EDITOR:-vim} "$file"
  fi
}

# cdf - cd into the directory of the selected file
cdf() {
  local file
  local dir
  file=$(fzf +m -q "$1" -0) && dir=$(dirname "$file") && cd "$dir" || exit 1
}

# c - browse chrome history
ch() {
  local cols sep google_history open
  cols=$(( COLUMNS / 3 ))
  sep='{::}'

  if [ "$(uname)" = "Darwin" ]; then
    google_history="$HOME/Library/Application Support/Google/Chrome/Default/History"
    open="open"
  else
    google_history="$HOME/.config/chromium/Default/History"
    open="mimeopen -n"
  fi

  cp -f "$google_history" /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
  from urls order by last_visit_time desc" \
    | awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' \
    | fzf --ansi -m \
    | sed 's#.*\(https*://\)#\1#' \
    | xargs "$open" > /dev/null 2> /dev/null
}

# fdp - cd to selected parent directory
fdp() {
  local dirs=()

  get_parent_dirs() {
    if [[ -d "${1}" ]]; then
      dirs+=("$1"); else return;
    fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do
        echo "$_dir";
      done
    else
      get_parent_dirs "$(dirname "$1")"
    fi
  }

  cd "$(get_parent_dirs "$(realpath "${1:-$PWD}")" | fzf --tac)" || exit 1
}

############################
# fuzzy processes commands #
############################

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]; then
    echo "$pid" | xargs kill -"${1:-9}"
  fi
}

#########################
#  fuzzy pacman search  #
#########################

# example usage: pacman -S $(fp)
fp() {
  local arg="-Ss"
  (( $# )) && { arg=$*; }
  echo -n "$(pacman "$arg" \
    | sed 'N;s/\n//' \
    | fzf -m \
    | sed 's/.*\///' \
    | sed 's/ .*//')"
}

######################
#  fuzzy man search  #
######################

fman() {
  man "$(apropos . | fzf | sed 's/ .*//')"
}
