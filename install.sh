#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -d ~/.config/nvim ] && [ ! -L ~/.config/nvim ]; then
  mv ~/.config/nvim ~/.config/nvim.bak
else
  rm -f ~/.config/nvim
fi

mkdir -p ~/.config
ln -s "${SCRIPT_DIR}" ~/.config/nvim

mkdir -p ~/.local/bin
if command -v nvim &> /dev/null; then
  ln -sf "$(command -v nvim)" ~/.local/bin/vim
  ln -sf "$(command -v nvim)" ~/.local/bin/vi
fi
