import configparser
import os
from pathlib import Path

lexet_mount_point = Path(os.environ['LEXET_MOUNT_POINT'])
lexet_path = Path(os.environ['LEXET_PATH'])
lexet_configs = Path(os.environ['LEXET_CONFIGS'])

class LexetConfig():
  def __init__(self, config):
    self.conf = configparser.ConfigParser()
    self.conf._interpolation = configparser.ExtendedInterpolation()

    self.conf['global'] = {}
    self.conf['global']['lexet_mount_point'] = str(lexet_mount_point)
    self.conf['global']['lexet_path'] = str(lexet_path)
    self.conf['global']['lexet_configs'] = str(lexet_configs)

    self.conf.read(config)

  def get_config(self):
    return self.conf

