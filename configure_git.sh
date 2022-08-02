set -e

alias gitcfg="git config --global"

gitcfg core.editor nvim
gitcfg pull.rebase false # merge on pull

unalias gitcfg

