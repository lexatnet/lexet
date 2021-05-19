
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
  def __init__(self, config, project):
    self.config = config
    self.project = project

  def start(self, mode):
    self.project.go_to_project_dir()
    if mode == 'text':
      self.run()
    elif mode == 'ui':
      self.run_x()
    elif mode == 'atom':
      self.run_atom()
    elif mode == 'python3':
      self.run_python3()
    else:
      logging.info('undefined start mode')

  def run(self):
    parts = []
    parts.append(
      str(
        Path(
          self.config['global']['lexet_mount_point'],
          'usr',
          'bin',
          'emacs',
        )
      )
    )

    parts.append('--no-window-system')

    parts.append('--no-init-file')

    parts.append(
      Template('--load $config')
      .substitute(
        config = self.config['root']['emacs_config']
      )
    )

    logging.info('run command "{command}"'.format(command=' '.join(parts)))
    os.system(' '.join(parts))

  def run_x(self):
    parts = []
    parts.append(
      str(
        Path(
          self.config['global']['lexet_mount_point'],
          'usr',
          'bin',
          'emacs',
        )
      )
    )

    parts.append('--no-init-file')

    parts.append(
      Template('--load $config')
      .substitute(
        config = self.config['root']['emacs_config']
      )
    )

    logging.info('run command "{command}"'.format(command=' '.join(parts)))
    os.system(' '.join(parts))

  def run_atom(self):
    parts = []
    parts.append(
      str(
        Path(
          self.config['global']['lexet_mount_point'],
          'usr',
          'bin',
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
          'bin',
          'python3',
        )
      )
    )

    logging.info('run command "{command}"'.format(command=' '.join(parts)))
    os.system(' '.join(parts))
