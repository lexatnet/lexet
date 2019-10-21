from shutil import copyfile, copytree
import os
from pathlib import Path
from string import Template
import logging


class LexetHome():
  def __init__(self, config, home):
    self.config = config
    self.home = home

  def exists(self):
    return Path(self.home).expanduser().exists()

  def create(self):
    logging.info('creation lexet root')
    self.create_home_dir()
    self.init_config()

  def create_home_dir(self):
    logging.info(
      Template('creation home directory "$home"')
      .substitute(
        home = self.home
      )
    )
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
    logging.info(
      Template('copy config template to "$config"')
      .substitute(
        config = self.config['init']['config']
      )
    )

    copyfile(
      Path(
        self.config['init']['config_src']
      ),
      Path(
        self.config['init']['config']
      ).expanduser(),
    )

  def copy_emacs_config(self):
    logging.info(
      Template('copy emacs config template to "$config"')
      .substitute(
        config = self.config['root']['emacs_config']
      )
    )
    copyfile(
      Path(
        self.config['init']['emacs_config_src']
      ),
      Path(
        self.config['root']['emacs_config']
      ).expanduser(),
    )

  def create_lexet_vendor_packages_dir(self):
    logging.info(
      Template('creation lexet vendor packages directory "$path"')
      .substitute(
        path = self.config['root']['vendor_packages_dir']
      )
    )
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
    path = str(
      Path(
        self.config['root']['emacs_config'],
        'tmp'
      ).expanduser()
    )

    logging.info(
      Template('creation lexet temporary files directory "$path"')
      .substitute(
        path = path
      )
    )
    command_parts = ['mkdir']
    command_parts.append('--parent')
    command_parts.append('--verbose')
    command_parts.append(path)
    os.system(' '.join(command_parts))

