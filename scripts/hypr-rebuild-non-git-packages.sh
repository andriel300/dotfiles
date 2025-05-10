#!/bin/bash
#hyprfix v2
#sudo /bin/pacman -Rdd $(/bin/pacman -Qsq "hypr|aqua") && sudo /bin/pacman -Syu && sudo /bin/
pacman -S $(/bin/pacman -Ssq "^hypr")
# v3
sudo /bin/pacman -Rdd $(/bin/pacman -Qsq "hypr|aqua") && sudo /bin/pacman -Syu && sudo /bin/p
acman -S $(/bin/pacman -Ssq "^hypr|xdg-desktop-portal-hyprland")
