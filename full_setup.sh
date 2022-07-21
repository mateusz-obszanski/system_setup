source ./my_utils.sh

rootcheck_rerun

main() {
	sudo apt update -y
	sudo apt upgrade -y

	echo "Setting up custom utilities..."
	./setup_my_utils.sh
	echo "Configuring dual boot with Windows..."
	./setup_systemd_windows_dual_boot.sh
	echo "Installing zsh..."
	./install_zsh.sh
	echo "Installing Neovim..."
	./install_neovim.sh
	echo "Configuring Neovim..."
	./configure_neovim
	echo "Installing Python..."
	./install_python
	echo "Installing other tools..."
	./install_programs.sh
	echo "Setting up custom zsh config..."
	./setup_my_shell_cfg.sh
	
	echo "Done"
	
	echo "Please, reboot e.g. by running:\nreboot"
}

main

