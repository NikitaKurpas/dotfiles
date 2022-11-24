setopt nobeep
unsetopt correct_all
unsetopt menu_complete
unsetopt share_history
autoload -U select-word-style compinit add-zsh-hook
select-word-style bash
compinit

stty -ixon

LOGO=🐧
if [[ -f /.dockerenv ]]; then
  LOGO=🐳️
elif [[ "$OSTYPE" = darwin* ]]; then
  LOGO=🍎
fi

PROMPT="${LOGO}%~%(?.. %F{red}%?%f)> "
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

function precmd () {
  print -Pn '\e]2;zsh: %~\a'
}

function preexec () {
  print -Pn '\e]2;'
  print -n "${(q)1}"
  print -Pn '\a'
}

alias gco="git checkout"
alias gra="git rebase --interactive --autosquash"
alias gram="git rebase --interactive --autosquash origin/master"
alias grm="git rebase origin/master"
alias gfa="git fetch --all"
alias gp="git push"
alias gpf="git push --force-with-lease"
alias gpr="git pull --rebase"
alias ts="tig status"
alias ntw="watch -n1 'npm test 2>&1'"
alias ll='ls -l'
alias sys='systemctl --user'
alias bt=bluetoothctl
alias qr='qrencode -t ANSI256'
alias decode-japanese-email='qprint -d | iconv --from-code=ISO-2022-JP'

alias be='bundle exec'

nr () {
  local package="$1"
  shift
  nix run nixpkgs."$package" -c "$package" "$@"
}

nsr () {
  nix-shell --pure --run "$*"
}

ns () {
  nix-shell --run "$*"
}

nrl() {
  local package="$1"
  shift
  nix run -f. "$package" -c "$package" "$@"
}

if [ -n "$TMUX" ]; then
  refresh-tmux() {
    eval $(tmux showenv -s)
  }

  add-zsh-hook -Uz preexec refresh-tmux

  e () {
    tmux split-window kak $*
  }
fi

if [[ "$OSTYPE" = darwin* ]]; then
  alias lsusb='ioreg -p IOUSB'
  alias nixup='nix-env -i --remove-all -f ~/Documents/dotfiles/nixos/mac.nix'
  alias sudo='sudo -H'
  alias arm='arch -arm64e'
fi

if [[ "$TERM" == xterm* ]]; then
  add-zsh-hook -Uz precmd precmd
  add-zsh-hook -Uz preexec preexec
fi

if [ "$TERM" = xterm-kitty ]; then
  alias icat='kitty +kitten icat'
  alias d='kitty +kitten diff'
  alias gd='git difftool --no-symlinks --dir-diff'
  alias ssh='kitty +kitten ssh'
fi
