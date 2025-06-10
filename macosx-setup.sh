# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Create ssh key for github
ssh-keygen -t ed25519 -C "sridha.in@gmail.com"
eval "$(ssh-agent -s)"
touch ~/.ssh/config
echo "Host *
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519" >> ~/.ssh/config
ssh-add -K ~/.ssh/id_ed25519

# Install github CLI
brew install gh

# Install the ssh public keyfile to github
# Below command auto adds the ssh public key to gihtub if we choose ssh
# Make sure you have login to github in the default browser
gh auth login
# gh ssh-key add ~/.ssh/id_ed25519.pub --title "personal laptop"

# Install the dev tools
brew install tmux
brew install neovim
brew install mosh
brew install zsh
brew install node

brew install --cask visual-studio-code
brew install --cask obsidian

npm i -g vim-language-server

# Install the dotfiles
gh repo clone sridharsridha/dotfiles
cd ~/dotfiles/
./install.sh



