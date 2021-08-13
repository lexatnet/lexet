import os
import argparse

class LexetArgumentParser():
  def parse_args(self, args):
    argsList = list(args)
    parser = argparse.ArgumentParser(
      description='''\
Emacs build with useful utils
configured for speed and comfortable writing code
from console or UI versions of emacs.
'''
    )

    parser.add_argument(
      '-H', '--home',
      action='store',
      dest='home',
      default=['~/.lexet'],
      nargs=1,
      help='''
Path to lexet local files. Default: ~/.lexet
'''
    )

    parser.add_argument(
      '-c', '--config',
      action='store',
      dest='config',
      default=['~/.lexet/config'],
      nargs=1,
      help='''
Path to config. Default: ~/.lexet/config
'''
    )

    parser.add_argument(
      '-a', '--action',
      action='store',
      dest='action',
      nargs=1,
      choices=['run', 'test'],
      default=['run'],
      help='''
For future extensions of functionality. Default: run
'''

    )
    parser.add_argument(
      '-m', '--mode',
      action='store',
      dest='mode',
      nargs=1,
      choices=['atom', 'python3'],
      default=['atom'],
      help='''
Allows to run application in console mode. Default: atom
'''
    )

    return parser.parse_args(argsList)
