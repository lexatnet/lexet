import os
import logging
from string import Template

class LexetEnv():
  def __init__(self, config, project):
    self.config = config
    self.project = project

  def set(self):
    os.environ['lexet_vendor_packages_dir'] = self.config['root']['vendor_packages_dir']
    self.log_defined_variable('lexet_vendor_packages_dir', os.environ['lexet_vendor_packages_dir'])

    os.environ['lexet_packages_dir'] = self.config['root']['packages_dir']
    self.log_defined_variable('lexet_packages_dir', os.environ['lexet_packages_dir'])

    os.environ['lexet_tmp_dir'] = self.config['root']['lexet_tmp_dir']
    self.log_defined_variable('lexet_tmp_dir', os.environ['lexet_tmp_dir'])

    os.environ['lexet_tags_dir'] = self.project.get_lexet_tags_dir()
    self.log_defined_variable('lexet_tags_dir', os.environ['lexet_tags_dir'])

    os.environ['ctags_exclude_config_path'] = self.config['root']['ctags_exclude_config']
    self.log_defined_variable('ctags_exclude_config_path', os.environ['ctags_exclude_config_path'])

  def log_defined_variable(self, name, value):
    logging.info(
      Template('Defined variable "$name" with "$value" value')
      .substitute(
        name = name,
        value = value
      )
    )
