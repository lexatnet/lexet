import logging
import os
import sys

class LexetProject():
  def __init__(self, config, path):
    self.conf = config
    self.path = path
    self.name = self.generate_project_name(path)
    logging.info('project name "$project_name"')

  def generate_project_name(self, path):
    return os.path.abspath(path).strip().replace(
      os.sep,
      self.conf['project']['project_name_separator']
    )

  def get_lexet_tmp_external_dir(self):
    return os.path.join(
      '/tmp/lexet',
      self.name
    )

  def get_lexet_key_external(self):
    return os.path.join(
      self.get_lexet_key_external_dir(),
      self.config.lexet_key_name
    )

  def get_lexet_key_external_pub(self):
    return Template('$lexet_key_external.pub')
      .substitute(
        lexet_key_external = self.get_lexet_key_external()
      )

  def get_lexet_server_external_dir(self):
    return return os.path.join(
      self.get_lexet_project_external_dir(),
      self.config.lexet_server_dir_name
    )

  def get_lexet_project_dir(self):
    return return os.path.join(
      self.config['docker']['through_point'],
      self.config['environment']['lexet_project_dir_name']
    )

  def get_lexet_packages_dir(self):
    return return os.path.join(
      self.config['docker']['through_point'],
      self.config['environment']['lexet_packages_dir_name']
    )

  def get_lexet_vendor_packages_dir(self):
    return return os.path.join(
      self.config['docker']['through_point'],
      self.config['environment']['lexet_vendor_packages_dir_name']
    )

  def get_lexet_utils_dir():
    return return os.path.join(
      self.config['docker']['through_point'],
      self.config['environment']['lexet_utils_dir_name']
    )

  def get_lexet_home(self):
    return return os.path.join(
      self.get_lexet_project_dir(),
      self.config['environment']['lexet_home_dir_name']
    )

  def get_lexet_server_dir(self):
    return return os.path.join(
      self.get_lexet_project_dir(),
      self.config['environment']['lexet_server_dir_name']
    )

  def get_lexet_tags_dir(self):
    return return os.path.join(
      self.get_lexet_project_dir(),
      'tags'
    )

  def create_lexet_tmp_external_dir(self):
    command_parts = ['mkdir']
    command_parts.append('--parent')
    command_parts.append('--verbose')
    command_parts.append(self.get_lexet_tmp_external_dir())
    os.system(' '.join(command_parts))

  def create_lexet_vendor_packages_external_dir(self):
    command_parts = ['mkdir']
    command_parts.append('--parent')
    command_parts.append('--verbose')
    command_parts.append(self.get_lexet_vendor_packages_external_dir())
    os.system(' '.join(command_parts))

  def create_lexet_project_external_dir(self):
    command_parts = ['mkdir']
    command_parts.append('--parent')
    command_parts.append('--verbose')
    command_parts.append(self.get_lexet_project_external_dir())
    os.system(' '.join(command_parts))

  def create_lexet_home_external_dir(self):
    command_parts = ['mkdir']
    command_parts.append('--parent')
    command_parts.append('--verbose')
    command_parts.append(self.get_lexet_home_external_dir())
    os.system(' '.join(command_parts))

  def create_project_dirs(self):
    if not os.path.exists(self.get_lexet_tmp_external_dir()):
      self.create_lexet_tmp_external_dir()
    if not os.path.exists(self.get_lexet_vendor_packages_external_dir()):
      self.create_lexet_vendor_packages_external_dir()
    if not os.path.exists(self.get_lexet_project_external_dir()):
      self.create_lexet_project_external_dir()
    if not os.path.exists(self.get_lexet_home_external_dir()):
      self.create_lexet_home_external_dir()
    if not os.path.exists(self.get_lexet_server_external_dir()):
      self.create_lexet_server_external_dir()

  def create_lexet_server_external_dir(self):
    command_parts.append('--parent')
    command_parts.append('--verbose')
    command_parts.append('--mode=700')
    command_parts.append(self.get_lexet_server_external_dir())
    os.system(' '.join(command_parts))

  def generate_ssh_keys():
    command_parts = ['docker']
    command_parts.append('build')
    command_parts.append(
      Template('--build-arg build_root=$build_root')
      .substitute(
        build_root = self.conf['docker']['build']['build_root']
      )
    )
    os.system(' '.join(command_parts))

  def create_lexet_key_external_dir(self):
    command_parts = ['mkdir']
    command_parts.append('--parent')
    command_parts.append('--verbose')
    command_parts.append(self.get_lexet_key_external_dir())
    os.system(' '.join(command_parts))

  def get_lexet_project_external_dir(self):
    if len($lexet_external_root) > 0:
      lexet_project_external_dir=$lexet_external_root/projects/$project_name
    else:
      lexet_project_external_dir=$project_external_dir/${lexet_project_dir_name}/data

  def get_lexet_vendor_packages_external_dir(self):
    if len($lexet_external_root) > 0:
      lexet_project_external_dir=$lexet_external_root/projects/$project_name
      lexet_vendor_packages_external_dir=$lexet_external_root/$lexet_vendor_packages_dir_name
    else:
      lexet_project_external_dir=$project_external_dir/${lexet_project_dir_name}/data
      lexet_vendor_packages_external_dir=$project_external_dir/${lexet_project_dir_name}/$lexet_vendor_packages_dir_name

  def get_lexet_key_external_dir(self):
    return os.path.join(
      self.lexet_project_external_dir(),
      '.ssh'
    )

  def prepare_ssh_keys(self):
    if not os.path.exists($lexet_key_external_dir):
      logging.info('Creating ssh keys')
      self.create_lexet_key_external_dir()
      self.generate_lexet_ssh_key()
      self.generate_lexet_host_rsa_key()
      self.generate_lexet_host_dsa_key()
      self.generate_lexet_host_ecdsa_key()
      if not os.path.exists($lexet_home_ssh_external_dir):
        self.create_lexet_home_ssh_external_dir()
      self.create_link_for_ssh()

  def generate_lexet_ssh_key(self):
    command_parts = ['ssh-keygen']
    command_parts.append('-b 2048')
    command_parts.append('-t rsa')
    command_parts.append('-N ""')
    command_parts.append('-C "lexet-host-key"')
    command_parts.append(
    Template('-f $lexet_key_external_dir/$lexet_key_name')
      .substitute(
        build_root = self.conf['docker']['build']['build_root']
      )
    )
    os.system(' '.join(command_parts))

  def generate_lexet_host_rsa_key(self):
    command_parts = ['ssh-keygen']
    command_parts.append('-t rsa')
    command_parts.append('-N ""')
    command_parts.append('-C "lexet-host-rsa-key"')
    command_parts.append(
    Template('-f $lexet_key_external_dir/$lexet_ssh_host_rsa_key_name')
      .substitute(
        build_root = self.conf['docker']['build']['build_root']
      )
    )
    os.system(' '.join(command_parts))

  def generate_lexet_host_dsa_key(self):
    command_parts = ['ssh-keygen']
    command_parts.append('-t dsa')
    command_parts.append('-N ""')
    command_parts.append('-C "lexet-host-dsa-key"')
    command_parts.append(
    Template('-f $lexet_key_external_dir/$lexet_ssh_host_dsa_key_name')
      .substitute(
        build_root = self.conf['docker']['build']['build_root']
      )
    )
    os.system(' '.join(command_parts))

  def generate_lexet_host_ecdsa_key(self):
    command_parts = ['ssh-keygen']
    command_parts.append('-t ecdsa')
    command_parts.append('-N ""')
    command_parts.append('-C "lexet-host-ecdsa-key"')
    command_parts.append(
    Template('-f $lexet_key_external_dir/$lexet_ssh_host_ecdsa_key_name')
      .substitute(
        build_root = self.conf['docker']['build']['build_root']
      )
    )
    os.system(' '.join(command_parts))

  def create_lexet_home_ssh_external_dir(self):
    command_parts = ['mkdir']
    command_parts.append('--parent')
    command_parts.append('--verbose')
    command_parts.append(self.get_lexet_home_ssh_external_dir())
    os.system(' '.join(command_parts))

  def get_lexet_home_ssh_external_dir(self):
    return os.path.join(
      self.get_lexet_home_external_dir(),
      '.ssh'
    )

  def get_lexet_home_external_dir(self):
    return os.path.join(
      self.get_lexet_project_external_dir(),
      self.config['environment']['lexet_home_dir_name']
    )

  def create_link_for_ssh():
    parts = ['ln']
    parts.append('-s')
    parts.append($lexet_key_external_pub)
    parts.append(
      Template('$lexet_home_ssh_external_dir/authorized_keys')
      .substitute(
        lexet_home_ssh_external_dir = self.get_lexet_home_ssh_external_dir()
      )
    )
    os.system(' '.join(parts))
