import logging
import os

class LexetUninstaller():
  def __init__(self, config):
    self.config = config

  def uninstall(self):
    logging.info('removing links...')
    os.unlink(self.config.conf['install']['install_point_lexet'])
    logging.info('links removed.')
    logging.info('removing data...')
    shutil.rmtree(self.config.conf['install']['lexet_external_root'])
    logging.info('data removed.')
