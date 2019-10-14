
import getpass
import os
from string import Template
import logging
import tempfile
import uuid
import subprocess
import time

file_path = os.path.realpath(__file__)
dir_path = os.path.dirname(file_path)
root = os.path.abspath(
  os.path.join(
    dir_path,
    os.pardir,
    os.pardir
  )
)


class LexetStarter():
  def __init__(self, conf, project):
    self.conf = conf
    self.project = project

  def start(self, mode):
    if mode == 'text':
      self.run()
    elif mode == 'ui':
      self.run_x()
    else:
      logging.info('undefined start mode')

  def run(self):
    parts = []
    parts.append(
      os.path.join(
        root,
        'usr',
        'bin',
        'emacs',
      )
    )
    logging.info('run command "{command}"'.format(command=' '.join(parts)))
    os.system(' '.join(parts))

  def run_x(self):
    parts = []
    parts.append(
      os.path.join(
        root,
        'usr',
        'bin',
        'emacs',
      )
    )

    parts.append('-q --load ~/.lexet/.emacs')

    logging.info('run command "{command}"'.format(command=' '.join(parts)))
    os.system(' '.join(parts))
