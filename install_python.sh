source ~/my/dev/shell/my_utils.sh

rootcheck_rerun

main() {
	local python_version="3.10.5"
	local download_url="https://www.python.org/ftp/python/$python_version/Python-$python_version.tar.xz"

	sudo apt update
	sudo apt install -y build-essential zlib1g-dev \
		libncurses5-dev libgdbm-dev libnss3-dev \
		libssl-dev libreadline-dev libffi-dev curl

	curl -O "$download_url"
	tar -xf "Python-$python_version.tar.xz"
	cd "Python-$python_version"
	# ./configure
	./configure --enable-optimizations --prefix=$HOME/my/programs/Python-$python_version

	sudo make altinstall
	rm "Python-$python_version.tar.xz"
	sudo rm -rf "Python-$python_version"
}

main

