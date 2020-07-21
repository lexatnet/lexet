#!/bin/bash

get_script_dir () {
     SOURCE="${BASH_SOURCE[0]}"
     # While $SOURCE is a symlink, resolve it
     while [ -h "$SOURCE" ]; do
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )"
          # If $SOURCE was a relative symlink (so no "/" as prefix, need to resolve it relative to the symlink base directory
     done
     DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
     echo "$DIR"
}

lib_index() {
  local dir=$(get_script_dir)

  echo "Library directory \"$dir\""
  echo 'Libs loading.......'

  source $dir/try.sh
  source $dir/trim.sh
  source $dir/generate_sshd_config.sh
  source $dir/generate_lexet_user_profile.sh
  source $dir/normalize_path.sh
  source $dir/get_script_dir.sh
  source $dir/patch_usr.sh
  source $dir/install_ruby.sh
  source $dir/install_sbcl.sh
  source $dir/install_node.sh
  source $dir/add_user.sh
  source $dir/incremental_tags_generation.sh
  source $dir/create_lexet_desktop_file.sh
  source $dir/install_utils.sh
  source $dir/install_nvm.sh
  source $dir/install_node.sh
  source $dir/install_ctags.sh
  source $dir/install_hunspell.sh
  source $dir/copy_libs.sh
  source $dir/install_gulp.sh
  source $dir/install_prettier.sh
  source $dir/install_jscs.sh
  source $dir/install_eslint.sh
  source $dir/install_jshint.sh
  source $dir/install_bower.sh
  source $dir/install_ruby_from_sources.sh
  echo 'Libs loaded.'
}

lib_index
