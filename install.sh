#!/usr/bin/env bash

mkdir -p ~/.config/nvim ~/.local/bin
rm -f ~/.config/nvim/init.vim
ln -sf "${PWD}/init.lua" ~/.config/nvim/

if command -v brew &> /dev/null; then
  ln -sf "$(brew --prefix)/bin/nvim" ~/.local/bin/vim
  ln -sf "$(brew --prefix)/bin/nvim" ~/.local/bin/vi
fi
