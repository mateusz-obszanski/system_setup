#!/usr/bin/zsh

set -e

# download and compile
if [ ! -x $(command -v helix) ]; then
    git clone https://github.com/helix-editor/helix --depth=1
    cd helix
    cargo install --path helix-term

    if [ "$1" -ne "--no-cleanup" ]; then
        cd ..
        rm -rf ./helix
    fi
else
    echo "skipping, helix already installed"
fi

# download themes
local themes_dir="$HOME/.config/helix/themes"

if [ ! -d "$themes_dir" ]; then
    mkdir "$themes_dir"
fi

for theme in rose_pine_dawn rose_pine_moon ayu_dark; do
    curl -sS https://raw.githubusercontent.com/helix-editor/helix/master/runtime/themes/$theme.toml \
        -o "$HOME/.config/helix/themes/$theme.toml"
done
