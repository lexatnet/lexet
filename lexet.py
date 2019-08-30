import logging
import os
import sys
from lib import LexetArgumentParser
from lib import LexetConfig
from lib import LexetProject
from lib import LexetBuilder
from lib import LexetInstaller
from lib import LexetUninstaller
from lib import LexetStarter

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
    self.configure()

  def parseArgs(self, args):
    parser = LexetArgumentParser()
    self.args = parser.parse_args(args)
    self.argsParsed = True

  def configure(self):
    self.config = LexetConfig(self.args.config).get_config()

  def install(self):
    installer = LexetInstaller(self.config)
    installer.install()

  def uninstall(self):
    uninstaller = LexetUninstaller(self.config)
    uninstaller.uninstall()

  def run(self):
    project_path = self.args.project.pop()
    self.project = LexetProject(self.config, project_path)
    starter = LexetStarter(self.config, self.project)
    mode = self.args.mode.pop()
    starter.start(mode)

  def runAction(self):
    action = self.args.action.pop()
    # import pdb; pdb.set_trace()
    getattr(self, action)()


def main():
  try:
    args = sys.argv
    lexet = Lexet(args)
    lexet.runAction()
  except Exception as ex:
    import pdb; pdb.set_trace()
    print(ex)

if __name__ == "__main__":
    # execute only if run as a script
    main()
