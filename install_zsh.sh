source ~/my/dev/shell/my_utils.sh
rootcheck_rerun
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
if [ -f .zshrc ]; then
	echo "replacing generated .zshrc with custom one"
	cp -f .zshrc ~
fi
