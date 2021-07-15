from shutil import copytree
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
    self.prepare_atom_home()

  def prepare_atom_home(self):
    logging.info(
      Template('copy atom home to "$atom_home"')
      .substitute(
        atom_home = self.config['root']['atom_home']
      )
    )

    copytree(
      Path(
        self.config['init']['atom_home']
      ),
      Path(
        self.config['root']['atom_home']
      ).expanduser(),
    )
