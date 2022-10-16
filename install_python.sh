#!/usr/bin/zsh

. ~/my/dev/shell/my_utils.sh

# args:
# - path to Python executable
_install_python_modules() {
	local python_cmd="$1"
	alias _pipinstall="$python_cmd -m pip install"
	{
		_pipinstall -U pip &&
			_pipinstall -U wheel setuptools &&
			_pipinstall ipython
	} || {
		local last_status=$!
		unalias _pipinstall
		exit $last_status
	}

}

_install_poetry() {
	local python_cmd="$1"
	curl -sSL https://install.python-poetry.org | "$python_cmd" -
}

_configure_poetry() {
	poetry config virtualenvs.prefer-active-python true
	poetry config virtualenvs.in-project true
}

_install_pyenv() {
	curl https://pyenv.run | $SHELL
	echo "TODO add ~/.pyenv/bin to PATH permanently"
}

_compile_python() {
	local python_version="3.10.7"
	local download_url="https://www.python.org/ftp/python/$python_version/Python-$python_version.tar.xz"
	local target_dir="$HOME/my/programs/Python-$python_version"
	local starting_location=$(pwd)

	dupinstall \
		build-essential \
		gdb \
		lcov \
		pkg-config \
		libbz2-dev \
		libffi-dev \
		libgdbm-dev \
		libgdbm-compat-dev \
		liblzma-dev \
		libncurses5-dev \
		libreadline6-dev \
		libsqlite3-dev \
		libssl-dev \
		lzma \
		lzma-dev \
		tk-dev \
		uuid-dev \
		zlib1g-dev

	curl -O "$download_url"
	tar -xf "Python-$python_version.tar.xz"
	cd "Python-$python_version"

	{ # try
		# loadable sqlite because of import error
		# sudo apt install sqlite-devel # or libsqlite3-dev on some Debian-based systems
		set -e -u

		./configure \
			--enable-optimizations \
			--enable-loadable-sqlite-extensions \
			--prefix="$target_dir"

		make -s
		sudo make altinstall
		rm "Python-$python_version.tar.xz"
		sudo rm -rf "Python-$python_version"
		_install_python_modules "$target_dir/python${python_version%.[[:digit:]]}"
	} || { # except
		local last_err_status=$!
	}
	{ # finally
		set -e -u
		cd "$starting_location"
		if [ -n $last_err_status ]; then
			exit $last_err_status
		fi
	}
}

# requires pyenv
_install_latest_python() {
	pyenv update && pyenv install -s 3:latest
}

main() {
	set -o errexit -o nounset

	_install_pyenv
	_install_latest_python
	_install_poetry
	_configure_poetry
}

rootcheck_rerun
main
clean_utils_aliases
