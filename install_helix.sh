#!/usr/bin/zsh

set -e

if [ -x $(command -v helix) ]; then
    git clone https://github.com/helix-editor/helix --depth=1
    cd helix
    cargo install --path helix-term
else
    echo "skipping, helix already installed"
fi

if [ "$1" -ne "--no-cleanup" ]; then
    cd ..
    rm -rf ./helix
fi
