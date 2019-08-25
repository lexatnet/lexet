import getpass
import os

class LexetStarter():
  def __init__(self, conf, project):
    self.conf = conf
    self.project = project

  def start(self):
    self.run()

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
        project_external_dir = self.project.get_lexet_project_external_dir(),
        mount_point = self.conf['docker']['mount_point']
      )
    )
    parts.append(
      Template('--volume $lexet_project_external_dir:$lexet_project_dir')
      .substitute(
        lexet_project_external_dir = self.project.get_lexet_project_external_dir(),
        lexet_project_dir = self.project.get_lexet_project_dir()
      )
    )
    parts.append(
      Template('--volume $root/config/$emacs_config:$through_point/$emacs_config')
      .substitute(
        root = self.conf['global']['root'],
        emacs_config = self.conf['docker']['emacs_config'],
        through_point = self.conf['docker']['through_point']
      )
    )
    parts.append(
      Template('--volume $root/config/$ctags_exclude_config:$through_point/$ctags_exclude_config')
      .substitute(
        root = self.conf['global']['root'],
        ctags_exclude_config = self.conf['docker']['ctags_exclude_config'],
        through_point = self.conf['docker']['through_point']
      )
    )
    parts.append(
      Template('--volume $lexet_tmp_external_dir:$lexet_tmp_dir')
      .substitute(
        lexet_tmp_external_dir = self.project.get_lexet_tmp_external_dir(),
        lexet_tmp_dir = self.conf['docker']['lexet_tmp_dir']
      )
    )
    parts.append(
      Template('--volume $root/packages:$lexet_packages_dir')
      .substitute(
        root = self.conf['global']['root'],
        lexet_packages_dir = self.project.get_lexet_packages_dir()
      )
    )
    parts.append(
      Template('--volume $lexet_vendor_packages_external_dir:$lexet_vendor_packages_dir')
      .substitute(
        lexet_vendor_packages_external_dir = self.project.get_lexet_vendor_packages_external_dir(),
        lexet_vendor_packages_dir = self.project.get_lexet_vendor_packages_dir()
      )
    )
    parts.append(
      Template('--env-file $env_config')
      .substitute(
        env_config = self.conf['docker']['env_config']
      )
    )
    parts.append(
      Template('-e USER=$USER')
      .substitute(
        USER = getpass.getuser()
      )
    )
    parts.append(
      Template('-e HOME=$lexet_home')
      .substitute(
        lexet_home = self.project.get_lexet_home()
      )
    )
    parts.append(
      Template('-e lexet_home=$lexet_home')
      .substitute(
        lexet_home = self.project.get_lexet_home()
      )
    )
    parts.append(
      Template('-e lexet_server_dir=$lexet_server_dir')
      .substitute(
        lexet_server_dir = self.project.get_lexet_server_dir()
      )
    )
    parts.append(
      Template('-e lexet_tmp_dir=$lexet_tmp_dir')
      .substitute(
        lexet_tmp_dir = self.conf['docker']['lexet_tmp_dir']
      )
    )
    parts.append(
      Template('-e lexet_packages_dir=$lexet_packages_dir')
      .substitute(
        lexet_packages_dir = self.project.get_lexet_packages_dir()
      )
    )
    parts.append(
      Template('-e lexet_vendor_packages_dir=$lexet_vendor_packages_dir')
      .substitute(
        lexet_vendor_packages_dir = self.project.get_lexet_vendor_packages_dir()
      )
    )
    parts.append(
      Template('-e mount_point=$mount_point')
      .substitute(
        mount_point = self.conf['docker']['mount_point']
      )
    )
    parts.append(
      Template('-e through_point=$through_point')
      .substitute(
        through_point = self.conf['docker']['through_point']
      )
    )
    parts.append(
      Template('-e emacs_config=$emacs_config')
      .substitute(
        emacs_config = self.conf['docker']['emacs_config']
      )
    )
    parts.append(
      Template('-e project_name=$project_name')
      .substitute(
        project_name = self.project.name
      )
    )
    parts.append(
      Template('-e lexet_tags_dir=$lexet_tags_dir')
      .substitute(
        lexet_tags_dir = self.project.get_lexet_tags_dir()
      )
    )
    parts.append(
      Template('--workdir $workdir')
      .substitute(
        workdir = self.conf['environment']['workdir']
      )
    )
    parts.append('--interactive')
    parts.append('--tty')
    parts.append('--rm')
    parts.append(
      Template('--user $user_id:$group_id')
      .substitute(
        user_id = os.getuid(),
        group_id = os.getuid()
      )
    )
    parts.append('$image_tag')
    os.system(' '.join(parts))

  def run_x():
    parts = ['docker']
    parts.append('run')
    parts.append(
      Template('--name $project_name')
      .substitute(
        project_name = self.project.name
      )
    )
    parts.append(
      Template('--label "label=$label"')
      .substitute(
        label = self.conf['environment']['label']
      )
    )
    parts.append(
      Template('--volume $project_external_dir:$mount_point')
      .substitute(
        project_external_dir = self.project.get_lexet_project_external_dir(),
        mount_point = self.conf['docker']['mount_point']
      )
    )
    parts.append(
      Template('--volume $lexet_project_external_dir:$lexet_project_dir')
      .substitute(
        lexet_project_external_dir = self.project.get_lexet_project_external_dir(),
        lexet_project_dir = self.project.get_lexet_project_dir()
      )
    )
    parts.append(
      Template('--volume $_dir/lib:$through_point/lib')
      .substitute(
        _dir = os.path.join(
          self.conf['global']['root'],
          'scripts'
        ),
        through_point = self.conf['docker']['through_point']
      )
    )
    parts.append(
      Template('--volume $root/config/$emacs_config:$through_point/$emacs_config')
      .substitute(
        root = self.conf['global']['root'],
        emacs_config = self.conf['docker']['emacs_config'],
        through_point = self.conf['docker']['through_point']
      )
    )
    parts.append(
      Template('--volume $root/config/$ctags_exclude_config:$through_point/$ctags_exclude_config')
      .substitute(
        root = self.conf['global']['root'],
        ctags_exclude_config = self.conf['docker']['ctags_exclude_config'],
        through_point = self.conf['docker']['through_point']
      )
    )
    parts.append(
      Template('--volume $lexet_external_root/init:$through_point/init')
      .substitute(
        lexet_external_root = self.conf['environment']['lexet_external_root'],
        through_point = self.conf['docker']['through_point']
      )
    )
    parts.append(
      Template('--volume $lexet_external_root/env:$through_point/env')
      .substitute(
        lexet_external_root = self.conf['environment']['lexet_external_root'],
        through_point = self.conf['docker']['through_point']
      )
    )
    parts.append(
      Template('--volume $_dir/$entrypoint_run_lexet:$through_point/$entrypoint_run_lexet')
      .substitute(
        _dir = os.path.join(
          self.conf['global']['root'],
          'scripts'
        ),
        entrypoint_run_lexet = self.conf['environment']['entrypoint_run_lexet'],
        through_point = self.conf['docker']['through_point']
      )
    )
    parts.append(
      Template('--volume $lexet_tmp_external_dir:$lexet_tmp_dir')
      .substitute(
        lexet_tmp_external_dir = self.project.get_lexet_tmp_external_dir(),
        lexet_tmp_dir = self.conf['docker']['lexet_tmp_dir']
      )
    )
    parts.append(
      Template('--volume $root/packages:$lexet_packages_dir')
      .substitute(
        root = self.conf['global']['root'],
        lexet_packages_dir = self.project.get_lexet_packages_dir()
      )
    )
    parts.append(
      Template('--volume $lexet_vendor_packages_external_dir:$lexet_vendor_packages_dir')
      .substitute(
        lexet_vendor_packages_external_dir = self.project.get_lexet_vendor_packages_external_dir(),
        lexet_vendor_packages_dir = self.project.get_lexet_vendor_packages_dir()
      )
    )
    parts.append('--volume /tmp/.X11-unix:/tmp/.X11-unix:rw')
    parts.append(
      Template('--env-file $env_config')
      .substitute(
        env_config = self.conf['docker']['env_config']
      )
    )
    parts.append(
      Template('-e DISPLAY=$DISPLAY')
      .substitute(
        DISPLAY = os.environ['DISPLAY']
      )
    )
    parts.append('-e QT_X11_NO_MITSHM=1')
    parts.append('-e NO_AT_BRIDGE=1')
    parts.append(
      Template('-e USER=$USER')
      .substitute(
        USER = getpass.getuser()
      )
    )
    parts.append(
      Template('-e HOME=$lexet_home')
      .substitute(
        lexet_home = self.project.get_lexet_home()
      )
    )
    parts.append(
      Template('-e lexet_home=$lexet_home')
      .substitute(
        lexet_home = self.project.get_lexet_home()
      )
    )
    parts.append(
      Template('-e lexet_server_dir=$lexet_server_dir')
      .substitute(
        lexet_server_dir = self.project.get_lexet_server_dir()
      )
    )
    parts.append(
      Template('-e lexet_tmp_dir=$lexet_tmp_dir')
      .substitute(
        lexet_tmp_dir = self.conf['docker']['lexet_tmp_dir']
      )
    )
    parts.append(
      Template('-e lexet_packages_dir=$lexet_packages_dir')
      .substitute(
        lexet_packages_dir = self.project.get_lexet_packages_dir()
      )
    )
    parts.append(
      Template('-e lexet_vendor_packages_dir=$lexet_vendor_packages_dir')
      .substitute(
        lexet_vendor_packages_dir = self.project.get_lexet_vendor_packages_dir()
      )
    )
    parts.append(
      Template('-e mount_point=$mount_point')
      .substitute(
        mount_point = self.conf['docker']['mount_point']
      )
    )
    parts.append(
      Template('-e through_point=$through_point')
      .substitute(
        through_point = self.conf['docker']['through_point']
      )
    )
    parts.append(
      Template('-e emacs_config=$emacs_config')
      .substitute(
        emacs_config = self.conf['docker']['emacs_config']
      )
    )
    parts.append(
      Template('-e ctags_exclude_config_path=$through_point/$ctags_exclude_config')
      .substitute(
        through_point = self.conf['docker']['through_point'],
        ctags_exclude_config = self.conf['docker']['ctags_exclude_config']
      )
    )
    parts.append(
      Template('-e project_name=$project_name')
      .substitute(
        project_name = self.project.name
      )
    )
    parts.append(
      Template('-e lexet_tags_dir=$lexet_tags_dir')
      .substitute(
        lexet_tags_dir = self.project.get_lexet_tags_dir()
      )
    )
    parts.append(
      Template('--workdir $workdir')
      .substitute(
        workdir = self.conf['environment']['workdir'],
      )
    )
    parts.append('--rm')
    parts.append(
      Template('--entrypoint $through_point/$entrypoint_run_lexet')
      .substitute(
        through_point = self.conf['docker']['through_point'],
        entrypoint_run_lexet = self.conf['environment']['entrypoint_run_lexet']
      )
    )
    parts.append(
      Template('--user $user_id:$group_id')
      .substitute(
        user_id = os.getuid(),
        group_id = os.getuid()
      )
    )
    parts.append('$image_tag')
    os.system(' '.join(parts))

  def run_x_ssh():
    pass
