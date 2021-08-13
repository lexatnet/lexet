import os
import logging
from string import Template

class LexetEnv():
  def __init__(self, config):
    self.config = config

  def set(self):
    os.environ['lexet_root'] = self.config['environment']['root']
    self.log_defined_variable('lexet_root', os.environ['lexet_root'])

    os.environ['lexet_tmp_dir'] = self.config['root']['lexet_tmp_dir']
    self.log_defined_variable('lexet_tmp_dir', os.environ['lexet_tmp_dir'])

    os.environ['ATOM_HOME'] = self.config['root']['atom_home']
    self.log_defined_variable('ATOM_HOME', os.environ['ATOM_HOME'])



  def log_defined_variable(self, name, value):
    logging.info(
      Template('Defined variable "$name" with "$value" value')
      .substitute(
        name = name,
        value = value
      )
    )
