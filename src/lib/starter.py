
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
          'usr',
          'bin',
          'atom',
        )
      )
    )

    parts.append('--wait')

    new_env = dict(os.environ)   # Make a copy of the current environment
    home = str(Path(os.environ['HOME']))
    new_env['ATOM_HOME'] = str(
      Path(
        home,
        '.lexet',
        'bin',
        'atom',
      )
    )
    logging.info('run command "{command}"'.format(command=' '.join(parts)))
    subprocess.Popen(parts, env=new_env)


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
