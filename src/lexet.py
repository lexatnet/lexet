import logging
import os
import sys
import traceback
from pathlib import Path
from string import Template

from lib import LexetArgumentParser
from lib import LexetConfig
from lib import LexetStarter
from lib import LexetTester
from lib import LexetHome
from lib import LexetEnv

lexet_path = Path(os.environ['LEXET_PATH'])

logging.basicConfig(level=logging.DEBUG)

class Lexet():
  def __init__(self, args):
    logging.info(f'args = {args}')
    self.parseArgs(args[1:])
    self.configure()
    self.home()

  def init_env(self):
    self.env = LexetEnv(self.config)
    self.env.set()

  def parseArgs(self, args):
    parser = LexetArgumentParser()
    self.args = parser.parse_args(args)
    self.argsParsed = True

  def home(self):
    home_path = self.args.home.pop()
    home = LexetHome(self.config, home_path)
    if not home.exists():
      logging.info('lexet root doesn\'t exists')
      home.create()

  def configure(self):
    config_path = self.get_config_path()
    logging.info(
      Template('loading config "$config"')
      .substitute(
        config = config_path
      )
    )
    self.config = LexetConfig(config_path).get_config()

  def run(self):
    self.init_env()
    starter = LexetStarter(self.config)
    mode = self.args.mode.pop()
    starter.start(mode)

  def test(self):
    self.init_env()
    tester = LexetTester(self.config)
    tester.test()


  def get_config_path(self):
    root_config = Path(lexet_path, 'config')
    args_config = Path(self.args.config.pop())
    if args_config.exists() and args_config.is_file():
      return str(args_config)
    return str(root_config)

  def runAction(self):
    action = self.args.action.pop()
    logging.info(f'action= {action}')
    getattr(self, action)()


def main():
  try:
    args = sys.argv
    lexet = Lexet(args)
    lexet.runAction()
  except Exception as ex:
    logging.exception(ex)

if __name__ == "__main__":
    # execute only if run as a script
    main()
