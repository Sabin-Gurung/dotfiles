#!/usr/bin/env bash

link_nvim() {
  ln -s ~/dotfiles/nvim/after ~/.config/nvim
  ln -s ~/dotfiles/nvim/lua ~/.config/nvim
  ln -s ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua
  nvim --headless "+Lazy sync" +qa
}

link_ideavim() {
  ln -s ~/dotfiles/ideavimrc ~/.ideavimrc
}

link_vim() {
  ln -s ~/dotfiles/vimrc ~/.vimrc
}

link_lf() {
  ln -s ~/dotfiles/lf ~/.config/lf
}

link_yazi() {
  ln -s ~/dotfiles/yazi/keymap.toml ~/.config/yazi/keymap.toml
  ln -s ~/dotfiles/yazi/theme.toml ~/.config/yazi/theme.toml
  ln -s ~/dotfiles/yazi/yazi.toml ~/.config/yazi/yazi.toml
  ln -s ~/dotfiles/yazi/package.toml ~/.config/yazi/package.toml
}

link_tmux() {
  ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/bin/install_plugins
}

link_nvim
link_ideavim
link_vim
# link_lf
link_yazi
link_tmux
