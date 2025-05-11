#!/bin/bash
# Universal Linux GRUB Rescue Script for BTRFS and EXT4 systems
# Compatible with Arch, Debian, Fedora (UEFI only)
# Author: Andriel

set -e

# Colors
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

print_step() {
	echo -e "${GREEN}==> $1${RESET}"
}

# Detect distribution
if [ -f /etc/arch-release ]; then
	DISTRO="arch"
	PM_INSTALL="pacman -S --noconfirm"
	PM_CHECK="pacman -Qq"
	CHROOT_CMD="arch-chroot"
elif [ -f /etc/debian_version ]; then
	DISTRO="debian"
	PM_INSTALL="apt install -y"
	PM_CHECK="dpkg -l"
	CHROOT_CMD="chroot"
elif [ -f /etc/fedora-release ]; then
	DISTRO="fedora"
	PM_INSTALL="dnf install -y"
	PM_CHECK="dnf list installed"
	CHROOT_CMD="chroot"
else
	echo "Unsupported Linux distribution."
	exit 1
fi

# Detect EFI and root partitions
print_step "Detecting partitions..."
EFI_PARTITION=$(lsblk -o NAME,FSTYPE,TYPE,SIZE,MOUNTPOINT | grep -i 'vfat' | awk '{print "/dev/"$1}' | head -n 1)
ROOT_PARTITION=$(lsblk -o NAME,FSTYPE,MOUNTPOINT | grep -E 'btrfs|ext4' | grep -v '/boot\|/efi' | awk '{print "/dev/"$1}' | head -n 1)

if [[ -z "$EFI_PARTITION" || -z "$ROOT_PARTITION" ]]; then
	echo -e "${YELLOW}Error: Could not detect EFI or root partition.${RESET}"
	exit 1
fi

print_step "EFI partition: $EFI_PARTITION"
print_step "Root partition: $ROOT_PARTITION"

# Mount root
mkdir -p /mnt
mount $ROOT_PARTITION /mnt

# If Btrfs, mount subvolumes
if blkid $ROOT_PARTITION | grep -q 'btrfs'; then
	print_step "Detected BTRFS filesystem. Mounting subvolumes..."
	umount /mnt
	mount -o subvol=@ $ROOT_PARTITION /mnt
	mkdir -p /mnt/{home,var/log,var/cache,.snapshots}
	mount -o subvol=@home $ROOT_PARTITION /mnt/home
	mount -o subvol=@log $ROOT_PARTITION /mnt/var/log
	mount -o subvol=@cache $ROOT_PARTITION /mnt/var/cache
	mount -o subvol=@snapshots $ROOT_PARTITION /mnt/.snapshots
else
	print_step "Non-BTRFS filesystem detected. Proceeding with standard mount."
fi

# Mount EFI
mkdir -p /mnt/efi
mount $EFI_PARTITION /mnt/efi

# Chroot and reinstall GRUB
print_step "Entering chroot to reinstall GRUB..."
$CHROOT_CMD /mnt /bin/bash <<EOF

  echo -e "${YELLOW}Cleaning old GRUB EFI files...${RESET}"
  rm -rf /efi/EFI/GRUB
  rm -rf /boot/grub

  echo -e "${YELLOW}Checking and installing required packages...${RESET}"
  for pkg in grub efibootmgr os-prober; do
    if ! $PM_CHECK | grep -q "\$pkg"; then
      echo "[*] Installing \$pkg..."
      $PM_INSTALL \$pkg
    else
      echo "[✓] \$pkg already installed."
    fi
  done

  echo -e "${YELLOW}Reinstalling GRUB...${RESET}"
  grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB

  echo -e "${YELLOW}Generating new GRUB configuration...${RESET}"
  grub-mkconfig -o /boot/grub/grub.cfg

EOF

print_step "GRUB rescue complete! You can now reboot safely."
