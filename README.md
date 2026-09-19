# NVIM Config

## Prerequisites

- Neovim >= 0.11.0

## Installation

```shell
$ ./install.sh
```

## Language servers

```shell
$ npm install -g typescript-language-server vscode-langservers-extracted
$ brew install lua-language-server pyright ruff
```

## Treesitter parsers

In Neovim, install the recommended Treesitter parsers:

```vim
:TSInstall bash css html javascript json python tsx typescript yaml
```
