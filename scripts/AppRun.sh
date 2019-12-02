#!/bin/bash
HERE="$(dirname "$(readlink -f "${0}")")"
VER=$(ls "${HERE}/usr/share/emacs/" | head -n 1)
export LD_LIBRARY_PATH=${HERE}/usr/lib/x86_64-linux-gnu/:$HERE/lib/x86_64-linux-gnu/:$HERE/usr/lib/:${HERE}/lib/:$LD_LIBRARY_PATH
export PATH=${HERE}/usr/sbin:${HERE}/usr/bin:$PATH
export EMACSPATH=${HERE}/usr/share/emacs/$VER/
export EMACSDATA=$EMACSPATH/etc
export EMACSDOC=$EMACSPATH/etc
export EMACSLOADPATH=$EMACSPATH/site-lisp:$EMACSPATH/lisp:$EMACSPATH/lisp/emacs-lisp
export INFOPATH=./local/share/info

export LEXET_MOUNT_POINT="${HERE}"
export LEXET_PATH="${HERE}/lexet"
export LEXET_CONFIGS="${HERE}/config"

export PHP_INI_SCAN_DIR="${HERE}/etc/php/7.2/cli/conf.d/"

appimage_python3="${HERE}"/usr/bin/python3

export PYTHONPATH="${HERE}"/usr/lib/python3/dist-packages/

if [ -d ${HERE}/init ]; then
  for i in ${HERE}/init/*.sh; do
    if [ -r $i ]; then
      echo $i
      . $i
    fi
  done
  unset i
fi

$appimage_python3 "${HERE}"/lexet/lexet.py "$@"
