#!/usr/bin/env bash
set -e

# tmux plugins
git clone https://github.com/tmux-plugins/tpm \
  ~/.tmux/plugins/tpm || true

ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/lf ~/.config/lf
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/ideavimrc ~/.ideavimrc

# neovim plugins
nvim --headless "+Lazy! sync" +qa || true
