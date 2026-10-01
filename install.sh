#!/bin/sh

set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ "${1:-}" = "--clean" ]; then
  echo "Cleaning up Neovim share and cache data..."
  rm -rf "${HOME}/.local/share/nvim"
  rm -rf "${HOME}/.cache/nvim"
fi

if [ -d "${HOME}/.config/nvim" ] && [ ! -L "${HOME}/.config/nvim" ]; then
  mv "${HOME}/.config/nvim" "${HOME}/.config/nvim.bak"
else
  rm -rf "${HOME}/.config/nvim"
fi

mkdir -p "${HOME}/.config"
ln -s "${SCRIPT_DIR}" "${HOME}/.config/nvim"

mkdir -p "${HOME}/.local/bin"
if command -v nvim >/dev/null; then
  ln -sf "$(command -v nvim)" "${HOME}/.local/bin/vim"
  ln -sf "$(command -v nvim)" "${HOME}/.local/bin/vi"
fi
