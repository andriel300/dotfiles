#!/usr/bin/env bash
# RETIRED: unsafe for this machine's Secure Boot + Windows dual-boot setup.
# The former implementation guessed partitions, deleted GRUB files, and
# reinstalled GRUB without the required Secure Boot options or signing.
# Historical implementation remains available in Git history; do not run it.

set -euo pipefail

printf '%s\n' \
    'RETIRED: grub-rescue.sh is disabled. No recovery actions were performed.' \
    'Use a separately reviewed, machine-specific recovery procedure.' >&2
exit 1
