#!/usr/bin/zsh

set -e

. ~/my/dev/shell/my_utils.sh

rootcheck_rerun

# Fuzzy finder for commandline and vim plugin
dupinstall \
    fzf \
    tree

clean_utils_aliases
