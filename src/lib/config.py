import configparser
import os

class LexetConfig():
  def __init__(self, config):
    self.conf = configparser.ConfigParser()
    self.conf._interpolation = configparser.ExtendedInterpolation()

    file_path = os.path.realpath(__file__)
    dir_path = os.path.dirname(file_path)

    root = os.path.abspath(
      os.path.join(dir_path, os.pardir)
    )

    self.conf['global'] = {}
    self.conf['global']['root'] = root
    self.conf['global']['user_id'] = str(os.getuid())

    self.conf.read(config)

  def get_config(self):
    return self.conf
