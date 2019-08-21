import configparser
import os

class LexetConfig():
  def __init__(self, config):
    self.conf = configparser.ConfigParser()

    file_path = os.path.realpath(__file__)
    dir_path = os.path.dirname(file_path)

    root = os.path.abspath(
      os.path.join(dir_path, os.pardir)
    )

    self.conf['GLOBAL'] = root
    self.conf['user_id'] = os.getuid()

    self.conf.read(config)
