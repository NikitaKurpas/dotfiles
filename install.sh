#!/usr/bin/env bash

# Run without downloading:
# curl https://raw.githubusercontent.com/NikitaKurpas/dotfiles/master/install.sh | bash

# Close any open System Preferences panes, to prevent them from overriding settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `install.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Hello $(whoami)! Let's get you set up."

echo "mkdir -p ${HOME}/code"
mkdir -p "${HOME}/code"

echo "mkdir -p ${HOME}/code/personal"
mkdir -p "${HOME}/code/personal"

echo "mkdir -p ${HOME}/code/other"
mkdir -p "${HOME}/code/other"

############
# Prerequisites
############
echo "installing XCode CLI tools"
xcode-select --install

echo "installing homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

############
# Brew taps
############
echo "tapping required taps"
brew tap homebrew/cask-cask
brew tap homebrew/cask-fonts
brew tap beeftornado/rmtree # remove a formula and its unused dependencies

############
# Essential tools
############

echo "installing zsh"
brew install zsh

echo "installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "setting zsh as default"
chsh -s $(which zsh)

echo "installing iterm2"
brew cask install iterm2

############
# CLI tools
############
echo "brew installing stuff"
brew install \
	bash \
	grep \
	git \
	git-lfs \
	node \
	yarn \
	python \
	mas \
	brew-rmtree \
	imagemagick \
	ruby \
	openssh \
	ssh-copy-id

brew cleanup

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

############
# Fonts
############
echo "installing fonts"
brew cask install font-fira-code # For WebSstorm and VSCode
brew cask install font-firamono-nerd-font # For terminals

############
# Brew cask GUI tools
############

echo "brew cask installing stuff"
#
## Essential apps
brew cask install \
	google-chrome \
	slack \
	1password \
	authy \
	setapp
#
## QuickLook plugins
brew cask install \
	qlcolorcode \
	qlmarkdown \
	qlstephen \
	quicklook-json \
	webpquicklook
#
## Dev apps
brew cask install \
	jetbrains-toolbox \
	visual-studio-code \
	sourcetree \
	postman \
	# insomnia \
	# postico \
	sloth \
	figma \
	# toptracker

############
# Global NPM deps
############

echo "installing a few global npm packages"
npm install --global fkill-cli

# TODO: I probably need brew ruby for this one...
echo "installing a few global gems"
gem install colorls

############
# Restore settings
############

echo "installing useful stuff for oh-my-zsh"
# Powerlevel9k theme
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
# Fish-like autosuggestions for ZSH
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# SSH key
mkdir -p ~/.ssh

echo "Generating an RSA token"
ssh-keygen -t rsa -b 4096 -C "nikitakurpas@gmail.com"
eval "$(ssh-agent -s)"
echo "run 'pbcopy < ~/.ssh/id_rsa.pub' and paste that into GitHub"

# dotfiles
echo "cloning dotfiles"
git clone https://github.com/NikitaKurpas/dotfiles.git "${HOME}/dotfiles"
if [ -f "${HOME}/.zshrc" ]; then rm "${HOME}/.zshrc"; fi
ln -s "${HOME}/dotfiles/.zshrc" "${HOME}/.zshrc"
ln -s "${HOME}/dotfiles/.bash_profile" "${HOME}/.bash_profile"
ln -s "${HOME}/dotfiles/.ssh/config" "${HOME}/.ssh/config"
cd "${HOME}/dotfiles"
git remote set-url origin git@github.com:NikitaKurpas/dotfiles.git

# Git config
git config --global user.name "Nikita Kurpas"
git config --global user.email "nikitakurpas@gmail.com"
git config --global credential.helper osxkeychain

# iTerm config
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm2"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
# Add shell integration
curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh

############
# System customizations
############
echo "making system modifications"

# Make Chrome Two finger swipe for back and forward
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool TRUE

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

############
# Mac App Store
############

# mas install 1278508951 # Trello
mas install 1091189122 # Bear
# mas install 824171161 # Affinity Designer
mas install 1081413713 # Gif Brewery
# mas install 1370791134 # DigiDoc 4 client
mas install 497799835 # Xcode
mas install 424389933 # Final Cut Pro

# List of all previously installed apps
# 424389933 Final Cut Pro (10.4.6)
# 998255317 Bitcoin Ticker (1.3.1)
# 1284863847 Unsplash Wallpapers (1.3)
# 409183694 Keynote (9.1)
# 926036361 LastPass (4.4.0)
# 418777616 Standard Snake (2.1.3)
# 1278508951 Trello (2.10.14)
# 747648890 Telegram (5.6.1)
# 682658836 GarageBand (10.3.2)
# 1380446739 InjectionIII (1.6)
# 425424353 The Unarchiver (4.1.0)
# 434290957 Motion (5.4.3)
# 409203825 Numbers (6.1)
# 497799835 Xcode (10.3)
# 634159523 MainStage 3 (3.4.3)
# 1147396723 WhatsApp (0.3.4480)
# 409201541 Pages (8.1)
# 929507092 PhotoScape X (3.0.3)
# 408981434 iMovie (10.1.12)
# 1091189122 Bear (1.6.15)
# 1176895641 Spark (2.3.10)
# 803453959 Slack (4.0.2)
# 634148309 Logic Pro X (10.4.6)
# 824171161 Affinity Designer (1.7.2)
# 1081413713 GIF Brewery 3 (3.9.5)
# 1370791134 DigiDoc4 Client (4.2.2)
# 1265763895 VK Messenger (4.4.3)

############
# Final notes
############

echo "Manually install: Docker (https://hub.docker.com/editions/community/docker-ce-desktop-mac)"
echo "Manually install with JetBrains Toolbox: WebStorm"
echo "Manually install with Setapp: Bartender, Sip, Numi, ForkLift, iStat Menus, Paste, CleanMyMac X, Mosaic, Proxyman, Wallpaper Wizard, Be Focused, KeyKey Typing tutor, SideNotes"
