# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/${HOME}/.oh-my-zsh"

################################################################
# Powerlevel9k customization
################################################################

# Custom node major version checker
prompt_enhanced_node_version() {
  if [[ ! -f "$PWD/package.json" ]]; then
    return;
  fi

  local color="green"

  local node_version=$(node -v 2>/dev/null)
  [[ -z "${node_version}" ]] && return

  if [[ -f "$PWD/.nvmrc" ]] && (( $+functions[nvm_rc_version] )); then
    nvm_rc_version >/dev/null
    local nvm_rc_major=${"${NVM_RC_VERSION%%.*}"##*v}
    local current_node_major=${"${node_version%%.*}"##*v}
    if [[ ! "$current_node_major" =~ "$nvm_rc_major" ]]; then
      color="red"
    fi
  fi

  "$1_prompt_segment" "$0" "$2" "$color" "white" "${node_version:1}" 'NODE_ICON'
}

# POWERLEVEL9K_CUSTOM_NODE_VERSION="custom_node_version"
POWERLEVEL9K_MODE='nerdfont-complete'
# POWERLEVEL9K_COLOR_SCHEME='light'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND='black'
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='178'
# POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(background_jobs enhanced_node_version time)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status context root_indicator dir vcs)

################################################################

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"
ZSH_THEME="powerlevel9k/powerlevel9k"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=10

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
  # git-flow
  # dotenv # load .env automatically
  zsh-autosuggestions
  # osx # osx awesomness
  # docker
  # docker-compose
  yarn
  npm
  nvm
  # kubectl
  zsh_reload # adds the 'src' command to reload zsh config
  # vscode
  lol
  # brew
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='code -n -w'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

export DEFAULT_USER="nikitakurpas"
prompt_context(){}

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ll="ls -alh"
alias lc="colorls"
alias llc="lc -alh"
alias lcgs="lc -A --gs --sd"
alias clr="clear && printf '\e[3J'"
alias print_node_modules='find . -name "node_modules" -type d -prune -print | xargs du -chs'
alias delete_node_modules='find . -name "node_modules" -type d -prune -print -exec rm -rf '{}' \;'

# Path and other exports

# Reset PATH
#if [[ -x /usr/libexec/path_helper ]]; then
#	PATH=''
#  eval `/usr/libexec/path_helper -s`
#fi

# GNU grep
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"

# Ruby from brew
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$(ruby -e 'puts Gem.bindir'):$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Shit to make node-canvas compile
export PKG_CONFIG_PATH=/usr/local/Cellar/libffi/3.2.1/lib/pkgconfig/

# ColorLS tab completion
source $(dirname $(gem which colorls))/tab_complete.sh

# iTerm2 shell integration
source ~/.iterm2_shell_integration.zsh

# Work stuff
export EIKAIWA_BASEDIR="$HOME/code/iknow"

# Fuzzy matching autocomplete
# 0 -- vanilla completion (abc => abc)
# 1 -- smart case completion (abc => Abc)
# 2 -- word flex completion (abc => A-big-Car)
# 3 -- full flex completion (abc => ABraCadabra)
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:|?=** m:{a-z\-}={A-Z\_}'
