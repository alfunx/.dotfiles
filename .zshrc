# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/amariya/.oh-my-zsh

if [ "$TERM" != "linux" ]; then
  # Set name of the theme to load. Optionally, if you set this to "random"
  # it'll load a random theme each time that oh-my-zsh is loaded.
  # See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
  # ZSH_THEME="robbyrussell"
  # ZSH_THEME="powerlevel9k/powerlevel9k"
  # ZSH_THEME="agnoster"
  ZSH_THEME="agnoster-custom"
fi

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-syntax-highlighting command-not-found common-aliases)

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_aliases

eval `dircolors $HOME/.dir_colors`

# source ~/.dotfiles/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


############
#  CUSTOM  #
############

# Alternative colors
if [ "$TERM" = "linux" ]; then
    # echo -en "\e]P0282828" #black
    echo -en "\e]P0000000" #black
    echo -en "\e]P8928374" #darkgrey
    echo -en "\e]P1CC241D" #darkred
    echo -en "\e]P9FB4934" #red
    echo -en "\e]P298971A" #darkgreen
    echo -en "\e]PAB8BB26" #green
    echo -en "\e]P3D79921" #brown
    echo -en "\e]PBFABD2F" #yellow
    echo -en "\e]P4458588" #darkblue
    echo -en "\e]PC83A598" #blue
    echo -en "\e]P5B16286" #darkmagenta
    echo -en "\e]PDD3869B" #magenta
    echo -en "\e]P6689D6A" #darkcyan
    echo -en "\e]PE8EC07C" #cyan
    echo -en "\e]P7A89984" #lightgrey
    echo -en "\e]PFEBDBB2" #white
    clear #for background artifacting
fi

# Zsh options
setopt extendedglob
setopt complete_aliases

# No scrolllock
stty -ixon

# Gruvbox colors fix
if [ -f $HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh ]; then
  source $HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh
fi

# Man page colours
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[0;30m\e[48;5;208m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;35m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS='-iMRj.5'

# Alternative prompt
if [ "$TERM" = "linux" ]; then
  PROMPT='[%F{red}%B%n%b%f@%m %~]'
  PROMPT+='$(git_prompt_info)'
  PROMPT+=' %(?.%F{cyan}%B$%b%f.%F{red}%B$%b%f) '

  ZSH_THEME_GIT_PROMPT_PREFIX=" [%F{yellow}%B"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%b%f]"
  ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}%B*%b%f"
  ZSH_THEME_GIT_PROMPT_CLEAN=""
fi

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS='--height 30%
  --color fg:223,bg:235,hl:208,fg+:229,bg+:237,hl+:167
  --color info:246,prompt:214,pointer:214,marker:142,spinner:246,header:214'

# export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --follow -g "" '
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" 2> /dev/null'
export FZF_TMUX=1
export FZF_TMUX_HEIGHT=30%
# set -g FZF_CTRL_T_COMMAND "command find -L \$dir -type f 2> /dev/null | sed '1d; s#^\./##'"

export FZF_CTRL_T_OPTS="--no-reverse"
export FZF_CTRL_R_OPTS="--no-reverse"
export FZF_ALT_C_OPTS="--no-reverse"

# TMUX
if [ "$(pgrep termite | wc -l)" -eq "1" ] && [[ "$TERM" == "xterm-termite" ]]; then
  tmux attach -t main 2>&1 > /dev/null || tmux new -s main 2>&1 > /dev/null
fi

# Scripts path
export PATH="$PATH:/home/amariya/scripts"
export VISUAL="vim"
export EDITOR="vim"
