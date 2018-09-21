#!/bin/bash

incremental_tags_generation() {
 local file_list=''
 local tags_root=''
 local tags_prefix='TAGS'
 local tags_index=0
 local max_tag_file_size=51200
 local tags_files_list=''

   local args=("$@")

   while [[ $# -gt 0 ]]
   do
     key="$1"

     case $key in
       --file-list)
         file_list=$2
         shift # past argument
         shift # past value
         ;;
       --tags-root)
         tags_root=$2
         shift # past argument
         shift # past value
         ;;
       --tags-prefix)
         tags_prefix=$2
         shift # past argument
         shift # past value
         ;;
       --tags-files-list)
         tags_files_list=$2
         shift # past argument
         shift # past value
         ;;
       --max-tag-file-size)
         max_tag_file_size=$2
         shift # past argument
         shift # past value
         ;;
       *)    # unknown option
         shift # past argument
         ;;
     esac
   done
   set -- "${args[@]}" # restore positional parameters

   if [ -z "$tags_files_list" ]; then
     tags_files_list="${tags_root}/${tags_prefix}-list"
   fi

   if [[ ! -f "${tags_files_list}" ]]; then
     touch "${tags_files_list}"
   fi

   while read filename; do
     tags_file="${tags_root}/${tags_prefix}${tags_index}"
     if [[ $(find "${tags_file}" -type f -size "+${max_tag_file_size}c" 2>/dev/null) ]]
     then
       ((tags_index++))
       tags_file="${tags_root}/${tags_prefix}${tags_index}"
     fi
     if [[ -f "${tags_file}" ]]; then
       ctags -e --append -f "${tags_file}" "${filename}"
     else
       ctags -e -f "${tags_file}" "${filename}"
       echo "${tags_file}" >> "${tags_files_list}"
     fi
   done < "$file_list"
}


script_name=$( basename ${0#-} ) #- needed if sourced no path
this_script=$( basename ${BASH_SOURCE} )
if [[ ${script_name} = ${this_script} ]] ; then
    incremental_tags_generation "$@"
fi
