
# Important stuff first
alias c="clear"

[ -z "$HOME" ] && echo "No \$HOME defined"; exit 1

# Install deps
if type pacman > /dev/null; then
  pacman -S --noconfirm neovim zsh oh-my-zsh-git
elif type apt-get > /dev/null; then
  apt-get install neovim zsh oh-my-zsh
else
  echo "pacman and apt-get not found, you have to manually install those packages:"; echo "neovim zsh oh-my-zsh"
  exit 1
fi

# Backup existing dotfiles
[ -e "$HOME/.config/nvim/" ] && mv "$HOME/.config/nvim/" "$HOME/.config/nvim_pre_setupscript/"
[ -f "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$HOME/.zshrc_pre_setupscript"

# Symlink new files
ln -s "$HOME/.config/nvim/" ./nvim/
ln -s "$HOME/.zshrc" ./.zshrc
