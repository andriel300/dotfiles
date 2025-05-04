#!/bin/bash

# REBUILD ALL GIT PAACKAGES THAT YOU HAVE IN YOU LINUX
yay -Qq | grep -E '(.+?-git)$' | yay -S --rebuild --noconfirm -
