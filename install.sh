#!/usr/bin/env bash

rm -f ~/.config/nvim
ln -s "${PWD}" ~/.config/nvim

mkdir -p ~/.local/bin
if command -v brew &> /dev/null; then
  ln -sf "$(brew --prefix)/bin/nvim" ~/.local/bin/vim
  ln -sf "$(brew --prefix)/bin/nvim" ~/.local/bin/vi
fi
