import getpass
import os
from string import Template
import logging
import tempfile
import uuid
import subprocess
import time
from pathlib import Path


class LexetStarter():
  def __init__(self, config):
    self.config = config

  def start(self, mode):
    if mode == 'atom':
      self.run_atom()
    elif mode == 'python3':
      self.run_python3()
    else:
      logging.info('undefined start mode')

  def run_atom(self):
    parts = []
    parts.append(
      str(
        Path(
          self.config['global']['lexet_mount_point'],
          'atom',
          'atom',
        )
      )
    )

    parts.append('--wait')

    logging.info('run command "{command}"'.format(command=' '.join(parts)))
    os.system(' '.join(parts))


  def run_python3(self):
    parts = []
    parts.append(
      str(
        Path(
          self.config['global']['lexet_mount_point'],
          'usr',
          'python3',
          'bin',
          'python3'
        )
      )
    )

    logging.info('run command "{command}"'.format(command=' '.join(parts)))
    os.system(' '.join(parts))
