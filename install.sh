#!/usr/bin/env bash

mkdir -p ~/.config/nvim ~/.local/bin
ln -sf "${PWD}/init.vim" ~/.config/nvim/
ln -sf "$(brew --prefix)/bin/nvim" ~/.local/bin/vim
