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
          'atom',
          'atom',
        )
      )
    )

    parts.append('--wait')

    # new_env = dict(os.environ)   # Make a copy of the current environment
    # home = str(Path(os.environ['HOME']))
    # new_env['ATOM_HOME'] = str(
    #   Path(
    #     home,
    #     '.lexet',
    #     'bin',
    #     'atom',
    #   )
    # )

    logging.info('run command "{command}"'.format(command=' '.join(parts)))

    # subprocess.Popen(parts, env=new_env)
    subprocess.Popen(
        parts,
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        shell=True
    )

    # set_env_script = '''
    #     if [ -d ${APPDIR}/init ]; then
    #       for i in ${APPDIR}/init/*.sh; do
    #         if [ -r $i ]; then
    #           echo $i
    #           . $i
    #         fi
    #       done
    #       unset i
    #     fi
    #
    #     echo $ATOM_HOME
    # '''
    #
    # script = '\n'.join([
    #     set_env_script,
    #     ' '.join(parts),
    # ])
    #
    # proc = subprocess.Popen(['bash'], stdin=subprocess.PIPE, stdout=subprocess.PIPE, env=new_env)
    # try:
    #     logging.info('script "{script}"'.format(script=script))
    #     outs, errs = proc.communicate(
    #         input=script.encode('utf-8'),
    #         timeout=15
    #     )
    #     logging.info('command output"{command_output}"'.format(command_output=outs.decode('utf-8')))
    #     logging.info('command errors"{errors}"'.format(errors=errs.decode('utf-8')))
    #     if errs:
    #         logging.info('command errors"{errors}"'.format(errors=errs.decode('utf-8')))
    # except subprocess.TimeoutExpired:
    #     proc.kill()
    #     logging.info('command timeout expired')


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
