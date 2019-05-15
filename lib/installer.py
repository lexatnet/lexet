import logging
import os

class LexetInstaller():
  def __init__(self, config):
    self.config = config

  def install(self):
    logging.info('Creation links...')
    os.symlink(
      os.path.join(
        self.config.conf['global']['root']
        'lexet'
      ),
      self.config.conf['install']['install_point_lexet']
    )
    logging.info('links created.')
