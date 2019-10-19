from shutil import copyfile, copytree
import os
from pathlib import Path
from string import Template

class LexetHome():
  def __init__(self, config, home):
    self.config = config
    self.home = home

  def exists(self):
    return os.path.exists(self.home)

  def create(self):
    self.create_home_dir()
    self.init_config()

  def create_home_dir(self):
    command_parts = ['mkdir']
    command_parts.append('--parent')
    command_parts.append('--verbose')
    command_parts.append(self.home)
    os.system(' '.join(command_parts))

  def init_config(self):
    self.copy_config_template()
    self.copy_emacs_config()
    self.create_lexet_vendor_packages_dir()
    self.create_lexet_tmp_dir()

  def copy_config_template(self):
    copyfile(
      Path(
        self.config['init']['config_src']
      ),
      Path(
        self.config['init']['config']
      ).expanduser(),
    )

  def copy_emacs_config(self):
    copyfile(
      Path(
        self.config['init']['emacs_config_src']
      ),
      Path(
        self.config['root']['emacs_config']
      ).expanduser(),
    )

  def create_lexet_vendor_packages_dir(self):
    command_parts = ['mkdir']
    command_parts.append('--parent')
    command_parts.append('--verbose')
    command_parts.append(
      str(
        Path(
        self.config['root']['vendor_packages_dir']
      ).expanduser()
      )
    )
    os.system(' '.join(command_parts))


  def create_lexet_tmp_dir(self):
    command_parts = ['mkdir']
    command_parts.append('--parent')
    command_parts.append('--verbose')
    command_parts.append(
      str(
        Path(
          self.config['root']['emacs_config']
        ).expanduser()
      )
    )
    os.system(' '.join(command_parts))

