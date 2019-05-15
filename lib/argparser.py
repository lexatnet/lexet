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
      '-c', '--config',
      action='store',
      dest='config',
      nargs=1
    )
    parser.add_argument(
      '-a', '--action',
      action='store',
      dest='action',
      nargs=1,
      choices=['install', 'build', 'run']
    )
    parser.add_argument(
      '-m', '--mode',
      action='store',
      dest='mode',
      nargs=1
    )
    return parser.parse_args(argsList)
