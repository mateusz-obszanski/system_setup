source ~/my/dev/shell/my_utils.sh

rootcheck_rerun

_install_python_modules() {
    local python_cmd="$1"
    $python_cmd -m pip install -U pip
    $python_cmd -m pip install -U wheel setuptools
    $python_cmd -m pip install ipython
}

main() {
	local python_version="3.10.5"
	local download_url="https://www.python.org/ftp/python/$python_version/Python-$python_version.tar.xz"
    local target_dir="$HOME/my/programs/Python-$python_version"

	sudo apt update
	sudo apt install -y build-essential zlib1g-dev \
		libncurses5-dev libgdbm-dev libnss3-dev \
		libssl-dev libreadline-dev libffi-dev curl

	curl -O "$download_url"
	tar -xf "Python-$python_version.tar.xz"
	cd "Python-$python_version"

    # loadable sqlite because of import error
    # sudo apt install sqlite-devel # or libsqlite3-dev on some Debian-based systems
    sudo apt install -y libsqlite3-dev
	./configure --enable-optimizations --enable-loadable-sqlite-extensions --prefix="$target_dir"

	make && sudo make altinstall
	rm "Python-$python_version.tar.xz"
	sudo rm -rf "Python-$python_version"

    _install_python_modules "$target_dir/python${python_version%.[[:digit:]]}"
}

main

