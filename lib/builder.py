class LexetBuilder():
  def __init__(self, config):
    self.conf = config

  def build(self):
    command_parts = ['docker']
    command_parts.append('build')
    command_parts.append(
      Template('--build-arg build_root=$build_root')
      .substitute(
        build_root = self.conf['docker']['build']['build_root']
      )
    )
    command_parts.append(
      Template('--build-arg build_script=$build_script')
      .substitute(
        build_script = self.conf['docker']['build']['build_script']
      )
    )
    command_parts.append(
      Template('--build-arg entrypoint_script=$entrypoint_script')
      .substitute(
        entrypoint_script = self.conf['docker']['build']['entrypoint_script']
      )
    )
    command_parts.append(
      Template('--tag $image_tag')
      .substitute(
        image_tag = self.conf['global']['image_tag']
      )
    )
    command_parts.append(
      Template('--file $docker_file')
      .substitute(
        docker_file = self.conf['docker']['build']['docker_file']
      )
    )
    command_parts.append(
      Template('$root')
      .substitute(
        root = self.conf['global']['root']
      )
    )
    os.system(' '.join(command_parts))
