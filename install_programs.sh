#!/usr/bin/zsh

set -e

. ~/my/dev/shell/my_utils.sh

rootcheck_rerun

# Fuzzy finder for commandline and vim plugin
dupinstall \
    fzf \
    tree \
    cmake \
    htop

clean_utils_aliases
