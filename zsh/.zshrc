#Timeout
KEYTIMEOUT=1

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=20000
SAVEHIST=20000
setopt appendhistory
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/usr/local/google/home/chaselewis/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/usr/local/google/home/chaselewis/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
 CASE_SENSITIVE="true"

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
plugins=(
    git
    zsh-autosuggestions
    tmuxinator
    web-search
    fasd
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Disable history sharing
unsetopt share_history

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

# Include timestamp on the right
RPROMPT="[%*]"

# Set editor
export EDITOR=nvim
export VISUAL=nvim

# Enable fasd
eval "$(fasd --init auto)"

alias vi="nvim"
alias vim="nvim"

### Google###

# Aliases and sources
source /etc/bash_completion.d/g4d
source /etc/bash_completion.d/hgd
source /etc/bash.bashrc.d/shell_history_forwarder.sh
alias ac="gcert && cideraccess"
alias ~~="cd /google/src/files/head/depot/google3"
alias fu="fileutil"
alias full="fileutil ls -l"
alias tmux="tmx2"
compdef tmx2=tmux

# SSH connections
if [[ -n $SSH_CONNECTION ]] ; then
  if ! gcertstatus; then
    gcert && cideraccess
  fi
fi

# Attach/start tmux on SSH login
if [[ -n "$PS1" ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_CONNECTION" ]]; then
  tmux attach-session -d -t ssh_tmux || tmux new-session -s ssh_tmux
fi

# Rename tmux pane to citc workspace
function tmux_title() {
  if [[ $PWD =~ /google/src/cloud/[^/]+/([^/]+)/.* ]]; then
    tmx2 rename-window "${match[1]}"
  else
    # tmx2 rename-window "$(basename `pwd`)"
  fi
}
if [[ ! -z "$TMUX" ]]; then
  precmd_functions+=(tmux_title)
fi

# Load chat room url from secrets file (format: export WEBHOOK_URL=url)
source ~/.chathook
# Send messages to the Notification chat room.
function notify() {
  NOTIFY_OUT="$@"
  curl \
      -s \
      -X POST \
      -H 'Content-Type: application/json' \
      "$WEBHOOK_URL" \
      -d "{'text': '${NOTIFY_OUT}'}" \
  > /dev/null && echo "Notification Sent"
}
alias pingme="notify Task Complete"

# Automatic retry for g4 submission.
function submit() {
  echo "===   CD   ==="
  g4d "$1"
  sleep 2s
  echo "===  gFIX  ===\n"
  g4 fix
  for i in {1..999}
    do
      echo "\n===  SYNC  ===\n"
      g4 sync
      echo "\n=== STATUS ===\n"
      gcertstatus
      if [ "$?" -ne 0]; then
        return [1]
      fi
      echo "\n=== SUBMIT ===\n"
      yes | g4 submit -c "$1"
      if [ $? -eq 0 ]; then
        echo "\n=== MERGED ===\n"
        notify "Change submitted\nhttp://cl/$1"
        return 0
      else
        echo "\n=== FAILED ===\n"
        echo "\n===  WAIT  ===\n"
        notify "Retrying submittion in 3 minutes\nhttp://cl/$1"
        sleep 3m
      fi
    done
}

