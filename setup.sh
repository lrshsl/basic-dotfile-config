#!/bin/sh

# Important stuff first
alias c="clear"



## Following part is written with the help of ChatGPT

# Check for required files
if [ ! -f "$(pwd)/.zshrc" ] || [ ! -d "$(pwd)/nvim" ]; then
  echo "Required files not found in current directory"
  exit 1
fi

# Install necessary packages
sudo pacman -S neovim zsh git

# Install packer.nvim
git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Install ohmyzsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Backup existing .zshrc
if [ -f ~/.zshrc ]; then
  mv ~/.zshrc ~/.zshrc.bak
fi

# Backup existing nvim folder
if [ -d ~/.config/nvim/ ]; then
  mv ~/.config/nvim/ ~/.config/nvim.bak/
fi

# Link .zshrc
ln -sf $(pwd)/.zshrc ~/.zshrc

# Link nvim dir
mkdir -p ~/.config/nvim/
ln -sf $(pwd)/nvim ~/.config/nvim/

# Reload shell
exec $SHELL




exit 0

# Version before chatGPT

scripthome="$HOME/.config/basic-dotfile-config"
[ "$(dirname "${BASH_SOURCE[0]}")" != ".config/basic-dotfile-config" ] && echo "This script must be run from $scripthome" && exit 1

# Install deps
if type pacman > /dev/null; then
  echo "starting pacman install"
  sudo pacman -S --noconfirm neovim packer zsh oh-my-zsh-git || exit 1
elif type apt-get > /dev/null; then
  echo "trying apt install"
  sudo apt-get install neovim zsh packer oh-my-zsh || echo "apt failed" && exit 1
else
  echo "pacman and apt-get not found, you have to manually install those packages:"; echo "neovim packer zsh oh-my-zsh"
  exit 1
fi

echo "install finished"

# Backup existing dotfiles
[ -d "$HOME/.config/nvim" ] && mv "$HOME/.config/nvim" "$HOME/.config/nvim_pre_setupscript"
[ -f "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$HOME/.zshrc_pre_setupscript"

[ -L "$HOME/.config/nvim" ] && rm "$HOME/.config/nvim"
[ -L "$HOME/.zshrc" ] && rm "$HOME/.zshrc"

# Symlink new files
ln -s "$scripthome"/nvim "$HOME"/.config/nvim || exit 1
ln -s "$scripthome"/.zshrc "$HOME"/.zshrc || exit 1


echo "Setup finished"

