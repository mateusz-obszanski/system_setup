#!/usr/bin/zsh

set -e

# TODO sed zsh plugins
echo "WARNING: TODO sed zsh plugins"

. ~/my/dev/shell/my_utils.sh

rootcheck_rerun

dupinstall zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

if [ -f .zshrc ]; then
	echo "replacing generated .zshrc with custom one"
	cp -f .zshrc ~
fi

clean_utils_aliases
