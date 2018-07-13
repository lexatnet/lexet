#!/bin/bash

source $through_point/lib/index.sh

add_user --user $USER --uid $user_id  --gid $group_id --user-home $lexet_home

su --command "source $through_point/lib/init.sh" -s /bin/bash $USER
