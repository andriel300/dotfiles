#!/usr/bin/env bash
# RETIRED: unsafe package-removal and rebuild procedure.
# The former implementation bypassed dependency checks with pacman -Rdd
# and contained a broken reinstall command, risking an unusable desktop.
# Historical implementation remains available in Git history; do not run it.

set -euo pipefail

printf '%s\n' \
    'RETIRED: hypr-rebuild-non-git-packages.sh is disabled. No packages were changed.' \
    'Diagnose the specific package problem before choosing a repair.' >&2
exit 1
