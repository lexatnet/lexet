import logging
import os
import sys

logging.basicConfig(level=logging.DEBUG)

file_path = os.path.realpath(__file__)
dir_path = os.path.dirname(file_path)
root = os.path.abspath(
  os.path.join(
    dir_path,
    os.pardir
  )
)

args = sys.argv

logging.info('args "{args}"'.format(args=args))

parts = []
parts.append(
  os.path.join(
    dir_path,
    'usr',
    'bin',
    'emacs',
  )
)

parts.append(
  '-q'
)

parts.append(
  os.path.join(
    dir_path,
    'usr',
    'bin',
    'emacs',
  )
)

# -q --load $through_point/$emacs_config

logging.info('run command "{command}"'.format(command=' '.join(parts)))
os.system(' '.join(parts))
