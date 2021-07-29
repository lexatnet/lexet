#!/usr/bin/env bash
HERE="$(dirname "$(readlink -f "${0}")")"
export LD_LIBRARY_PATH=${HERE}/usr/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=${HERE}/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=${HERE}/usr/lib/:${HERE}/lib/:$LD_LIBRARY_PATH
export PATH=${HERE}/bin:$PATH
export PATH=${HERE}/usr/sbin:$PATH
export PATH=${HERE}/usr/bin:$PATH
export INFOPATH=./local/share/info
export DICPATH=${HERE}/usr/share/hunspell:$DICPATH

# ruby env
# Search path for dynamically loaded modules.
# DLN_LIBRARY_PATH=
# export RUBYLIB=${HERE}/usr/lib/ruby/2.8.0/x86_64-linux/:${HERE}/usr/lib/ruby/2.8.0/
export RUBYLIB=${HERE}/usr/ruby/bin/lib/ruby/3.1.0:${HERE}/usr/ruby/bin/lib/ruby/3.1.0/x86_64-linux
export GEM_PATH=${HERE}/usr/ruby/bin/lib/ruby/gems/3.1.0
export PATH="${HERE}"/usr/ruby/bin/bin:$PATH
# export RUBYLIB=${HERE}/usr/ruby/bin/lib/ruby/3.1.0:${RUBYLIB}
# RUBYPATH=


export LEXET_MOUNT_POINT="${HERE}"
export LEXET_PATH="${HERE}/lexet"
export LEXET_CONFIGS="${HERE}/config"

export PHP_INI_SCAN_DIR="${HERE}/etc/php/7.2/cli/conf.d/"

# appimage_python3="${HERE}"/usr/python3/bin/python3

# export PATH=${HERE}/usr/python3/bin:$PATH
export PATH="${HERE}"/usr/python3/bin:$PATH
export PYTHONHOME="${HERE}"/usr/python3/lib/python3.9
export PYTHONPATH=$PYTHONHOME:"${HERE}"/usr/python3/lib/python3.9/lib-dynload:"${HERE}"/usr/python3/packages
# source "${HERE}"/usr/python3/venv/bin/activate

# export ATOM_HOME="${HOME}/.lexet/atom"

export PATH="${HERE}"/usr/ctags/bin:$PATH

export PATH="${HERE}"/usr/hunspell/bin/bin:$PATH

if [ -d ${HERE}/init ]; then
  for i in ${HERE}/init/*.sh; do
    if [ -r $i ]; then
      echo $i
      . $i
    fi
  done
  unset i
fi

# bash
# $appimage_python3 "${HERE}"/lexet/lexet.py "$@"
python "${HERE}"/lexet/lexet.py "$@"
