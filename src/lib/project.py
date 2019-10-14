import logging
import os
import sys
import tempfile
from string import Template

class LexetProject():
  def __init__(self, config, path):
    self.conf = config
    self.path = path
    self.name = self.generate_project_name(path)
    logging.info('project name "{project_name}"'.format(project_name = self.name))

  def generate_project_name(self, path):
    # import pdb; pdb.set_trace()
    return os.path.abspath(path).strip().replace(
      os.sep,
      self.conf['project']['project_name_separator']
    ).strip('.')

  def get_lexet_home(self):
    return os.path.join(
      self.get_lexet_project_dir(),
      self.conf['environment']['root']
    )

  def get_lexet_tags_dir(self):
    return os.path.join(
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

  def create_project_dirs(self):
    if not os.path.exists(self.get_lexet_tmp_external_dir()):
      self.create_lexet_tmp_external_dir()
    if not os.path.exists(self.get_lexet_vendor_packages_external_dir()):
      self.create_lexet_vendor_packages_external_dir()
    if not os.path.exists(self.get_lexet_project_external_dir()):
      self.create_lexet_project_external_dir()
    if not os.path.exists(self.get_lexet_home_external_dir()):
      self.create_lexet_home_external_dir()

  def get_lexet_project_external_dir(self):
    if len(self.conf['environment']['lexet_external_root']) > 0:
      return os.path.join(
        self.conf['environment']['lexet_external_root'],
        'projects',
        self.name
      )
    else:
      return os.path.join(
        self.path,
        self.conf['environment']['lexet_project_dir_name'],
        'data'
      )

  def get_lexet_vendor_packages_external_dir(self):
    if len(self.conf['environment']['lexet_external_root']) > 0:
      return os.path.join(
        self.conf['environment']['lexet_external_root'],
        self.conf['environment']['lexet_vendor_packages_dir_name'],
      )
    else:
      return os.path.join(
        self.path,
        self.conf['environment']['lexet_project_dir_name'],
        self.conf['environment']['lexet_vendor_packages_dir_name'],
      )
