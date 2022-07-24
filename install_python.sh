#!/usr/bin/zsh

set -e

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

main() {
	set -e

	local python_version="3.10.5"
	local download_url="https://www.python.org/ftp/python/$python_version/Python-$python_version.tar.xz"
	local target_dir="$HOME/my/programs/Python-$python_version"
	local starting_location=$(pwd)

	dupinstall \
		build-essential zlib1g-dev \
		libncurses5-dev \
		libgdbm-dev \
		libnss3-dev \
		libssl-dev \
		libreadline-dev \
		libffi-dev curl

	curl -O "$download_url"
	tar -xf "Python-$python_version.tar.xz"
	cd "Python-$python_version"
	{ # try
		# loadable sqlite because of import error
		# sudo apt install sqlite-devel # or libsqlite3-dev on some Debian-based systems
		set -e

		dupinstall libsqlite3-dev
		./configure \
			--enable-optimizations \
			--enable-loadable-sqlite-extensions \
			--prefix="$target_dir"
		make
		sudo make altinstall
		rm "Python-$python_version.tar.xz"
		sudo rm -rf "Python-$python_version"
		_install_python_modules "$target_dir/python${python_version%.[[:digit:]]}"
	} || { # except
		local last_err_status=$!
	}
	{ # finally
		set -e
		cd "$starting_location"
		if [ -n $last_err_status ]; then
			exit $last_err_status
		fi
	}
}

rootcheck_rerun
main
clean_utils_aliases
