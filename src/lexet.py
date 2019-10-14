import logging
import os
import sys
import traceback
from lib import LexetArgumentParser
from lib import LexetConfig
from lib import LexetProject
from lib import LexetBuilder
from lib import LexetStarter
from lib import LexetHome
from lib import LexetEnv

file_path = os.path.realpath(__file__)
dir_path = os.path.dirname(file_path)
root = os.path.abspath(
  os.path.join(
    dir_path,
    os.pardir
  )
)

logging.basicConfig(level=logging.DEBUG)

class Lexet():
  def __init__(self, args):
    self.parseArgs(args[1:])
    self.home()
    self.configure()

  def env(self):
    self.env = LexetEnv(self.config, self.project)
    self.env.set()

  def parseArgs(self, args):
    parser = LexetArgumentParser()
    self.args = parser.parse_args(args)
    self.argsParsed = True

  def home(self):
    home = LexetHome(self.args.home)
    if not home.exists():
      home.create()

  def configure(self):
    self.config = LexetConfig(self.args.config).get_config()

  def run(self):
    project_path = self.args.project.pop()
    self.project = LexetProject(self.config, project_path)
    self.env()
    starter = LexetStarter(self.config, self.project)
    mode = self.args.mode.pop()
    starter.start(mode)

  def runAction(self):
    action = self.args.action.pop()
    getattr(self, action)()


def main():
  try:
    args = sys.argv
    lexet = Lexet(args)
    lexet.runAction()
  except Exception as ex:
    logging.error('ERROR: '.format(exception=ex.to))
    logging.error('ERROR: stacktrace'.format0(stacktrace=traceback.format_exc()))
    # import pdb; pdb.set_trace()

if __name__ == "__main__":
    # execute only if run as a script
    main()
