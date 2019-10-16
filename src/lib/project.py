import logging
import os
import sys
import tempfile
from string import Template
import re

class LexetProject():
  def __init__(self, config, path):
    self.conf = config
    self.path = path
    self.name = self.generate_project_name(path)
    logging.info('project name "{name}"'.format(name = self.name))

  def generate_project_name(self, path):
    return self.strip(
      os.path.abspath(path).strip().replace(
        os.sep,
        self.conf['project']['project_name_separator']
      ),
      self.conf['project']['project_name_separator']
    )

  def strip(self, string, search):
    reg_exp = re.compile(
      Template('(^$search)|($search$$)')
      .substitute(
        search = search
      )
    )
    return reg_exp.sub('', string)

  def get_lexet_tags_dir(self):
    return os.path.join(
      self.get_lexet_project_dir(),
      'tags'
    )

  def create_lexet_project_dir(self):
    command_parts = ['mkdir']
    command_parts.append('--parent')
    command_parts.append('--verbose')
    command_parts.append(self.get_lexet_project_dir())
    os.system(' '.join(command_parts))

  def create_project_dirs(self):
    if not os.path.exists(self.get_lexet_project_dir()):
      self.create_lexet_project_dir()

  def get_lexet_project_dir(self):
    return os.path.join(
      self.conf['environment']['root'],
      self.conf['root']['projects_dir']
    )
