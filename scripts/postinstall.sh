#!/usr/bin/env bash

# Post-Install Setup Script
# For Arch Linux with existing zsh and dotfiles configurations
# Author: Andriel
# GitHub Dotfiles: https://github.com/andriel300/dotfiles/tree/main

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$(id -u)" -eq 0 ]; then
	echo -e "${RED}Error: This script should not be run as root. Run as a normal user.${NC}"
	exit 1
fi

# Function to install packages with error handling
install_pkgs() {
	echo -e "${YELLOW}Installing: $@${NC}"
	if ! sudo pacman -S --needed --noconfirm "$@"; then
		echo -e "${RED}Error installing packages: $@${NC}"
		exit 1
	fi
}

# Update system first
echo -e "${YELLOW}Updating system...${NC}"
sudo pacman -Syu --noconfirm

# Install base packages (excluding those already handled by your zshrc)
BASE_PKGS=(
	neovim
	waybar
	eza
	git
	wget
	curl
	jq
	python-pip
	python-virtualenv
	ripgrep
	fd
	bat
	unzip
	zip
	man-db
	man-pages
	texinfo
	noto-fonts
	noto-fonts-cjk
	noto-fonts-emoji
	ttf-jetbrains-mono
	ttf-font-awesome
	otf-font-awesome
	xdg-utils
	xdg-user-dirs
	polkit-gnome
	brightnessctl
	playerctl
	pavucontrol
	networkmanager
	bluez
	vim
	# --------------------------------------------------- // Theming
	nwg-look    # gtk configuration tool
	qt5ct       # qt5 configuration tool
	qt6ct       # qt6 configuration tool
	kvantum     # svg based qt6 theme engine
	kvantum-qt5 # svg based qt5 theme engine
	qt5-wayland # wayland support in qt5
	qt6-wayland # wayland support in qt6
	bluez-utils
	blueman
	gvfs
	gvfs-mtp
	mtpfs
	jmtpfs
	gvfs-nfs
	gvfs-smb
	nfs-utils
	sshfs
	lazygit
	yazi
	pokemon-colorscripts
	pacman-contrib
	sddm
)

install_pkgs "${BASE_PKGS[@]}"

# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
nvm install --lts

# Verify the Node.js version:
node -v     # Should print "v22.15.0".
nvm current # Should print "v22.15.0".

# Verify npm version:
npm -v # Should print "10.9.2".

# Install AUR helper (paru) if not installed
if ! command -v paru &>/dev/null && ! command -v yay &>/dev/null; then
	echo -e "${YELLOW}Installing paru (AUR helper)...${NC}"
	git clone https://aur.archlinux.org/paru.git /tmp/paru
	cd /tmp/paru || exit
	makepkg -si --noconfirm
	cd || exit
	rm -rf /tmp/paru
fi

# Determine AUR helper
if command -v yay &>/dev/null; then
	aurhelper="yay"
else
	aurhelper="paru"
fi

# Install AUR packages
AUR_PKGS=(
	oh-my-posh-bin
	ghostty-git
	eww
	# hyprland-nvidia-git # Remove if not using Nvidia
	hyprpicker-git
	hyprpaper-git
	hyprlock
	wlogout
	nwg-look-bin
	nwg-displays
	pamixer
	wob
	swww
	rofi-wayland
	wl-clipboard
	cliphist
	wf-recorder
	slurp
	grim
	tickrs
	sesh
	fzf
	imagemagick
	parallel
	fastfetch
	bun-bin
	sdkman
	code
	lmstudio-bin
)

echo -e "${YELLOW}Installing AUR packages...${NC}"
$aurhelper -S --needed --noconfirm "${AUR_PKGS[@]}"

# Configure pacman.conf with optimizations
echo -e "${YELLOW}Optimizing pacman configuration...${NC}"
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf
sudo sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
sudo sed -i 's/^#VerbosePkgLists/VerbosePkgLists/' /etc/pacman.conf

# Add ILoveCandy option
if ! grep -q "ILoveCandy" /etc/pacman.conf; then
	sudo sed -i '/VerbosePkgLists/a ILoveCandy' /etc/pacman.conf
fi

# Add chaotic-aur repository
if ! grep -q "chaotic-aur" /etc/pacman.conf; then
	echo -e "${YELLOW}Adding chaotic-aur repository...${NC}"
	sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
	sudo pacman-key --lsign-key 3056513887B78AEB
	sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
	sudo tee -a /etc/pacman.conf >/dev/null <<EOL
[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
EOL
fi

# Update again with new repos
echo -e "${YELLOW}Updating with new repositories...${NC}"
sudo pacman -Syu --noconfirm

# Check for existing dotfiles and create symlinks
echo -e "${YELLOW}Setting up dotfiles...${NC}"

# List of config directories to check
CONFIG_DIRS=(
	"hypr"
	"waybar"
	"eww"
	"nvim"
	"ghostty"
	"kitty"
	"alacritty"
	"rofi"
	"dunst"
	"swaync"
	"wlogout"
	"qt5ct"
	"gtk-3.0"
	"gtk-4.0"
	"Kvantum"
	"ohmyposh"
)

# Backup existing configs and create symlinks
for dir in "${CONFIG_DIRS[@]}"; do
	if [ -d "$HOME/.config/$dir" ] && [ ! -L "$HOME/.config/$dir" ]; then
		echo -e "${YELLOW}Backing up existing $dir config...${NC}"
		mv "$HOME/.config/$dir" "$HOME/.config/${dir}.bak"
	fi

	if [ -d "$HOME/dotfiles/$dir" ]; then
		echo -e "${YELLOW}Linking $dir config...${NC}"
		ln -sf "$HOME/dotfiles/$dir" "$HOME/.config/$dir"
	fi
done

# Special handling for files in ~/.config
CONFIG_FILES=(
	"picom.conf"
	"alacritty.toml"
)

for file in "${CONFIG_FILES[@]}"; do
	if [ -f "$HOME/.config/$file" ] && [ ! -L "$HOME/.config/$file" ]; then
		echo -e "${YELLOW}Backing up existing $file...${NC}"
		mv "$HOME/.config/$file" "$HOME/.config/${file}.bak"
	fi

	if [ -f "$HOME/dotfiles/$file" ]; then
		echo -e "${YELLOW}Linking $file...${NC}"
		ln -sf "$HOME/dotfiles/$file" "$HOME/.config/$file"
	fi
done

# Handle home directory dotfiles (excluding .zshrc since you have your own)
HOME_FILES=(
	".tmux.conf"
)

for file in "${HOME_FILES[@]}"; do
	if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
		echo -e "${YELLOW}Backing up existing $file...${NC}"
		mv "$HOME/$file" "$HOME/${file}.bak"
	fi

	if [ -f "$HOME/dotfiles/$file" ]; then
		echo -e "${YELLOW}Linking $file...${NC}"
		ln -sf "$HOME/dotfiles/$file" "$HOME/$file"
	fi
done

# Install SDKMAN if not installed
if [ ! -d "$HOME/.sdkman" ]; then
	echo -e "${YELLOW}Installing SDKMAN...${NC}"
	curl -s "https://get.sdkman.io" | bash
	source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

# Install bun if not installed
if ! command -v bun &>/dev/null; then
	echo -e "${YELLOW}Installing bun...${NC}"
	curl -fsSL https://bun.sh/install | bash
fi

# Final steps
echo -e "${YELLOW}Running final setup steps...${NC}"

# Enable bluetooth service
sudo systemctl enable --now bluetooth

# Enable NetworkManager
sudo systemctl enable --now NetworkManager

# Set up xdg user dirs
xdg-user-dirs-update

# Install LazyVim (if nvim config is linked)
if [ -d "$HOME/.config/nvim" ] && [ ! -f "$HOME/.config/nvim/init.lua" ]; then
	echo -e "${YELLOW}Setting up LazyVim...${NC}"
	git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"
	rm -rf "$HOME/.config/nvim/.git"
fi

# Clean up
echo -e "${GREEN}Cleaning up...${NC}"
sudo pacman -Sc --noconfirm

# Completion message
echo -e "${GREEN}
==========================================
Setup completed successfully!

Key modifications made:
1. Preserved your existing .zshrc configuration
2. Added ILoveCandy to pacman.conf
3. Added chaotic-aur repository
4. Installed all requested packages
5. Linked your existing dotfiles

Your AUR helper is: $aurhelper

Recommended next steps:
1. Restart your shell to apply changes
2. Start Hyprland with: Hyprland
3. Check your linked configs in ~/.config/

Backups of any existing configs were created with .bak extension
==========================================
${NC}"
