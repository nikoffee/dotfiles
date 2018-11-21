#!/bin/sh

if [ ! -d "$HOME/dotfiles" ]; then
  echo "Installing your dotfiles"
  git clone https://github.com/nikoffee/dotfiles.git "$HOME/dotfiles"
  cd "$HOME/dotfiles"

  rake install
else
  echo "Dotfiles already installed at $HOME/dotfiles"
fi
