#!/bin/bash

root="$(cd "$(dirname "$(readlink -f  "$0")")" && pwd)"

image_name='ubuntu-emacs-test'

mount_point='/volume'

dist_point='/tmp'

emacs_config='.emacs'

through_point='/ide'

env_config='env-config.sh'
