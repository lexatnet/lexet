#!/bin/bash

create_lexet_desktop_file(){
  local name='lexet.desktop'
  local args=("$@")

  while [[ $# -gt 0 ]]
  do
    key="$1"
    case $key in
      --name)
        nvm_root=$2
        shift # past value
        ;;
      *)    # unknown option
        shift # past argument
        ;;
    esac
  done
  set -- "${args[@]}" # restore positional parameters

  
cat > ${name} <<EOF
[Desktop Entry]
Type=Application
Name=Lexet
Comment=IDE
Icon=lexet
Exec=emacs %F
Terminal=false
Categories=Application;Development;
Keywords=Editor;
MimeType=text/x-python3;
EOF
}
