#!/bin/bash

sudo pacman -Qq | grep -E "(hypr|aqua)" | grep -- -git | yay -Syu --rebuild --rebuildall --rebuildtree --noconfirm -
