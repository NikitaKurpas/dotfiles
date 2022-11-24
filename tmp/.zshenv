if [ -z "$__ZSHENV_PATH_SET_ONCE" ]; then
  __ZSHENV_PATH_SET_ONCE=true
  path=(
    $HOME/doc/dotfiles/bin
    $HOME/Documents/dotfiles/bin
    $HOME/.npm/bin
    $HOME/.cargo/bin
    /opt/homebrew/bin
    $path
  )
fi

export EDITOR=kak
export PAGER="less"
export GNUPGHOME="$HOME/.config/gnupg"
export npm_config_prefix="$HOME/.npm"
export npm_config_cache="$HOME/.cache/npm"

if [[ "$OSTYPE" == linux-gnu ]]; then
  export LESS="--mouse --wheel-lines=5 --raw-control-chars"
fi

if [[ "$OSTYPE" == darwin* ]]; then
  export LANG="en_GB.UTF-8"

  if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    if [ -e "$HOME/.nix-defexpr/channels" ]; then
      export NIX_PATH="$HOME/.nix-defexpr/channels${NIX_PATH:+:$NIX_PATH}"
    fi
  fi

  if [ -e /opt/homebrew/bin/brew ]; then
    eval $(/opt/homebrew/bin/brew shellenv)
  fi
fi
