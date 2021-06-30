#!/usr/bin/env bash

install_appimage-builder(){
  # local nvm_root=''
  # local init_nvm_root=$nvm_root
  # local init_script='/etc/profile.d/nvm.sh'
  # local args=("$@")
  local cwd=$(pwd)
  #
  # while [[ $# -gt 0 ]]
  # do
  #   key="$1"
  #   case $key in
  #     --nvm-root)
  #       nvm_root=$2
  #       shift # past value
  #       ;;
  #     --init-nvm-root)
  #       init_nvm_root=$2
  #       shift # past value
  #       ;;
  #     --init-script)
  #       init_script=$2
  #       shift # past argument
  #       shift # past value
  #       ;;
  #     *)    # unknown option
  #       shift # past argument
  #       ;;
  #   esac
  # done
  set -- "${args[@]}" # restore positional parameters

  # wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage -O /usr/local/bin/appimagetool
  # chmod +x /usr/local/bin/appimagetool

  # Install appimagetool AppImage
  wget https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage -O /opt/appimagetool

  # workaround AppImage issues with Docker
  cd /opt/; chmod +x appimagetool; sed -i 's|AI\x02|\x00\x00\x00|' appimagetool; ./appimagetool --appimage-extract
  mv /opt/squashfs-root /opt/appimagetool.AppDir
  ln -s /opt/appimagetool.AppDir/AppRun /usr/local/bin/appimagetool

  # pip3 install appimage-builder
  pip3 install git+https://github.com/AppImageCrafters/appimage-builder.git
  # pip3 install git+https://github.com/lexatnet/appimage-builder.git@fix-double-slashes

  cd $cwd
}
