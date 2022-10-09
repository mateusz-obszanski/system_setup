#!/usr/bin/zsh

git clone https://github.com/helix-editor/helix --depth=1
cd helix
cargo install --path helix-term
