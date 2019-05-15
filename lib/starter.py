class LexetStarter():
  def __init__(self, config):
    self.config = config

  def run():
    parts = ['docker']
    parts.append('run')
    parts.append(
      Template('--label "label=$label"')
      .substitute(
        label = self.conf['environment']['label']
      )
    )
    parts.append(
      Template('--volume $project_external_dir:$mount_point')
      .substitute(
        project_external_dir = self.conf['environment']['label']
        mount_point = 
      )
    )
    parts.append('--volume $lexet_project_external_dir:$lexet_project_dir')
    parts.append('--volume $root/config/$emacs_config:$through_point/$emacs_config')
    parts.append('--volume $root/config/$ctags_exclude_config:$through_point/$ctags_exclude_config')
    parts.append('--volume $lexet_tmp_external_dir:$lexet_tmp_dir')
    parts.append('--volume $root/packages:$lexet_packages_dir')
    parts.append('--volume $lexet_vendor_packages_external_dir:$lexet_vendor_packages_dir')
    parts.append('--env-file $env_config')
    parts.append('-e USER=$USER'
    parts.append('-e HOME=$lexet_home')
    parts.append('-e lexet_home=$lexet_home')
    parts.append('-e lexet_server_dir=$lexet_server_dir')
    parts.append('-e lexet_tmp_dir=$lexet_tmp_dir')
    parts.append('-e lexet_packages_dir=$lexet_packages_dir')
    parts.append('-e lexet_vendor_packages_dir=$lexet_vendor_packages_dir')
    parts.append('-e mount_point=$mount_point')
    parts.append('-e through_point=$through_point')
    parts.append('-e emacs_config=$emacs_config')
    parts.append('-e project_name=$project_name')
    parts.append('-e lexet_tags_dir=$lexet_tags_dir')
    parts.append('--workdir $workdir')
    parts.append('--interactive')
    parts.append('--tty')
    parts.append('--rm')
    parts.append('--user $user_id:$group_id')
    parts.append('$image_tag')
    os.system(' '.join(parts))

  def run_x():
    parts = ['docker']
    parts.append('run')
    parts.append('--name $project_name')
    parts.append('--label "label=${label}"')
    parts.append('--volume $project_external_dir:$mount_point')
    parts.append('--volume $lexet_project_external_dir:$lexet_project_dir')
    parts.append('--volume $dir/lib:$through_point/lib')
    parts.append('--volume $root/config/$emacs_config:$through_point/$emacs_config')
    parts.append('--volume $root/config/$ctags_exclude_config:$through_point/$ctags_exclude_config')
    parts.append('--volume $lexet_external_root/init:$through_point/init')
    parts.append('--volume $lexet_external_root/env:$through_point/env')
    parts.append('--volume $dir/$entrypoint_run_lexet:$through_point/$entrypoint_run_lexet')
    parts.append('--volume $lexet_tmp_external_dir:$lexet_tmp_dir')
    parts.append('--volume $root/packages:$lexet_packages_dir')
    parts.append('--volume $lexet_vendor_packages_external_dir:$lexet_vendor_packages_dir')
    parts.append('--volume /tmp/.X11-unix:/tmp/.X11-unix:rw')
    parts.append('--env-file $env_config')
    parts.append('-e DISPLAY=$DISPLAY')
    parts.append('-e QT_X11_NO_MITSHM=1')
    parts.append('-e NO_AT_BRIDGE=1')
    parts.append('-e USER=$USER')
    parts.append('-e HOME=$lexet_home')
    parts.append('-e lexet_home=$lexet_home')
    parts.append('-e lexet_server_dir=$lexet_server_dir')
    parts.append('-e lexet_tmp_dir=$lexet_tmp_dir')
    parts.append('-e lexet_packages_dir=$lexet_packages_dir')
    parts.append('-e lexet_vendor_packages_dir=$lexet_vendor_packages_dir')
    parts.append('-e mount_point=$mount_point')
    parts.append('-e through_point=$through_point')
    parts.append('-e emacs_config=$emacs_config')
    parts.append('-e ctags_exclude_config_path=$through_point/$ctags_exclude_config')
    parts.append('-e project_name=$project_name')
    parts.append('-e lexet_tags_dir=$lexet_tags_dir')
    parts.append('--workdir $workdir')
    parts.append('--rm')
    parts.append('--entrypoint $through_point/$entrypoint_run_lexet')
    parts.append('--user $user_id:$group_id')
    parts.append('$image_tag')
    os.system(' '.join(parts))

  def run_x_ssh():


