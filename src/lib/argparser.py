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
      choices=['run'],
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
      choices=['text', 'ui', 'atom', 'python3'],
      default=['atom'],
      help='''
Allows to run application in console mode. Default: atom
'''
    )
    parser.add_argument(
      '-p', '--project',
      action='store',
      dest='project',
      nargs=1,
      default=[os.getcwd()],
      help='''
Path to working directory which you want to open. Default: current working directory
'''
    )
    parser.add_argument(
      '-w', '--workspace',
      action='store',
      dest='workspace',
      nargs=1,
      default=['default'],
      help='''
Name of workspace. Default: default
'''
    )
    return parser.parse_args(argsList)
