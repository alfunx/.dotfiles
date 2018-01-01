############
# dotfiles #
############

dotfiles() {
  case "$1" in
    listall)
      shift
      dotfiles ls-tree --full-tree -r --name-only HEAD "$@"
      ;;
    listtree)
      shift
      if hash treeify 2>/dev/null; then
        dotfiles ls-tree --full-tree -r --name-only HEAD "$@" | treeify
      else
        dotfiles listall
      fi
      ;;
    *)
      /usr/bin/env git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"
      ;;
  esac
}
compdef dotfiles=git

#############
#  aliases  #
#############

con() {
  case "$1" in
    vim)
      shift
      vim ~/.vimrc "$@"
      ;;
    tmux)
      shift
      vim ~/.tmux.conf "$@"
      ;;
    git)
      shift
      vim ~/.gitconfig ~/.gitignore ~/.gitmodules "$@"
      ;;
    zsh)
      shift
      vim ~/.zshrc ~/.zsh_aliases ~/.oh-my-zsh/themes/agnoster-custom.zsh-theme "$@"
      ;;
    bash)
      shift
      vim ~/.bashrc ~/.bash_profile "$@"
      ;;
    aw)
      shift
      vim ~/.config/awesome/rc.lua ~/.config/awesome/themes/powerarrow-gruvbox/theme.lua "$@"
      ;;
    xorg)
      shift
      vim ~/.xinitrc "$@"
      ;;
    script)
      shift
      vim ~/scripts/* "$@"
      ;;
    *)
      shift
      vim ~/.zsh_aliases "$@"
      ;;
  esac
}

mkcd() {
  mkdir -p "$@" && cd "$@"
}

toilol() {
  toilet -f mono12 -w "$(tput cols)" | lolcat "$@"
}

pacman() {
  local pattern="^-S[cuy]|^-S$|^-R[sn]|^-U"
  if [[ "$1" =~ $pattern ]]; then
    sudo /usr/bin/pacman "$@"
  else
    /usr/bin/pacman "$@"
  fi
}

tmux() {
  if [ "$TERM" = "linux" ]; then
    /usr/bin/tmux -L linux -f "$HOME/.tmux.minimal.conf" "$@"
  else
    /usr/bin/tmux "$@"
  fi
}

alias pg="ping -c 1 www.google.ch"

#########
#  fzf  #
#########

alias fzf="fzf-tmux -d 30%"

#############
#  ripgrep  #
#############

alias rg="rg --smart-case --line-number --colors=\"match:fg:red\" --colors=\"match:style:bold\" --colors=\"path:fg:white\" --colors=\"line:fg:yellow\" --colors=\"line:style:bold\""

# fuzzy rg
frg() {
  rg --smart-case --no-line-number --no-heading --color=always --colors="match:none" --colors="path:fg:white" --colors="line:fg:white" "$@" . | fzf --ansi
}

#######################
# the silver searcher #
#######################

alias ag="ag --smart-case --numbers --color-match \"1;31\" --color-path \"0;37\" --color-line-number \"1;33\""

# fuzzy ag
fag() {
  ag --smart-case --nobreak --nonumbers --noheading --color --color-match "" --color-path "0;37" --color-line-number "0;37" "$@" . | fzf --ansi
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
  cd "$(fd --follow --type d '.' ${1:-.} 2>/dev/null \
    | fzf +m -q "$1" -0)"
}

# # c - fda including hidden directories
# c() {
#   cd "$(find -L ${1:-.} -type d 2>/dev/null \
#     | fzf +m -q "$1" -0)"
# }

# c - fda including hidden directories
c() {
  cd "$(fd --hidden --follow --type d '.' ${1:-.} 2>/dev/null \
    | fzf +m -q "$1" -0)"
}

# # fr - cd to selected directory and open ranger
# fr() {
#   cd "$(find -L ${1:-.} -type d 2>/dev/null \
#     | fzf +m -q "$1" -0)" && ranger
# }

# fr - cd to selected directory and open ranger
fr() {
  cd "$(fd --hidden --follow --type d '.' ${1:-.} 2>/dev/null \
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
  file=$(fzf +m -q "$1" -0) && dir=$(dirname "$file") && cd "$dir"
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
    | xargs $open > /dev/null 2> /dev/null
}

# fdp - cd to selected parent directory
fdp() {
  local declare dirs=()

  get_parent_dirs() {
    if [[ -d "${1}" ]]; then
      dirs+=("$1"); else return;
    fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do
        echo $_dir;
      done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }

  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf --tac)
  cd "$DIR"
}

############################
# fuzzy processes commands #
############################

# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]; then
    echo $pid | xargs kill -${1:-9}
  fi
}

######################
# fuzzy git commands #
######################

# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "$branches" | fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(
  git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
  git branch --all | grep -v HEAD \
    | sed "s/.* //" | sed "s#remotes/[^/]*/##" | sort -u \
    | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
  (echo "$tags"; echo "$branches") |
    fzf -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fcoc - checkout git commit
fcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
    commit=$(echo "$commits" | fzf --tac +s +m -e) &&
    git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" \
    | fzf --ansi --no-sort --tac --tiebreak=index --bind=ctrl-s:toggle-sort \
    --bind "ctrl-m:execute:
  (grep -o '[a-f0-9]\{7\}' | head -1 |
    xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
  {}
  FZF-EOF"
}

# fcs - get git commit sha
# example usage: git rebase -i `fcs`
fcs() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit) &&
    commit=$(echo "$commits" | fzf +s +m -e --ansi) &&
    echo -n $(echo "$commit" | sed "s/ .*//")
}

# fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" \
      | fzf --ansi --no-sort -q "$q" --print-query \
      --expect=ctrl-d,ctrl-b);
  do
    mapfile -t out <<< "$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git stash show -p $sha
    fi
  done
}

#########################
#  fuzzy pacman search  #
#########################

# example usage: pacman -S $(fp)
fp() {
  local arg="-Ss"
  (( $# )) && { arg=$@; }
  echo -n "$(pacman $arg \
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

#################
#  transfer.sh  #
#################

transfer() {
  if [ $# -eq 0 ]; then
    echo -e "No arguments specified."
    return 1
  fi

  tmpfile=$( mktemp )
  if tty -s; then
    basefile=$(basename "$1" \
      | sed -e 's/[^a-zA-Z0-9._-]/-/g')
    curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile
  else
    curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile
  fi
  cat $tmpfile
  rm -f $tmpfile
}
