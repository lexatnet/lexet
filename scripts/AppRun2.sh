#!/usr/bin/env bash
# HERE="$(dirname "$(readlink -f "${0}")")"
HERE=$APPDIR
echo "HELLO!!!!!!!!!!!!!!!!!!"
# export LD_LIBRARY_PATH=${HERE}/usr/lib/x86_64-linux-gnu/:$HERE/lib/x86_64-linux-gnu/:$HERE/usr/lib/:${HERE}/lib/:$LD_LIBRARY_PATH
# export PATH=${HERE}/usr/sbin:${HERE}/usr/bin:$PATH
# export INFOPATH=./local/share/info
# export DICPATH=${HERE}/usr/share/hunspell

# export RUBYLIB=${HERE}/usr/lib/ruby/2.8.0/x86_64-linux/:${HERE}/usr/lib/ruby/2.8.0/

export LEXET_MOUNT_POINT="${HERE}"
export LEXET_PATH="${HERE}/lexet"
export LEXET_CONFIGS="${HERE}/config"

# export PHP_INI_SCAN_DIR="${HERE}/etc/php/7.2/cli/conf.d/"

appimage_python3="${HERE}"/usr/bin/python3
#
# export PATH=${HERE}/usr/python3/bin:$PATH
# export PYTHONPATH="${HERE}"/usr/python3/lib/python3.9
# source "${HERE}"/usr/python3/venv/bin/activate

export ATOM_HOME="${HOME}/.lexet/atom"

if [ -d ${HERE}/init ]; then
  for i in ${HERE}/init/*.sh; do
    if [ -r $i ]; then
      echo $i
      . $i
    fi
  done
  unset i
fi

python3 "${HERE}"/lexet/lexet.py "$@"
