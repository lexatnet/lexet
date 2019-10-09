import logging
import os
import sys
from lexet-lib import LexetArgumentParser
from lexet-lib import LexetConfig
from lexet-lib import LexetProject
from lexet-lib import LexetBuilder
from lexet-lib import LexetInstaller
from lexet-lib import LexetUninstaller
from lexet-lib import LexetStarter
from lexet-lib import LexetHome

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

  def parseArgs(self, args):
    parser = LexetArgumentParser()
    self.args = parser.parse_args(args)
    self.argsParsed = True

  def home(self):
    

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
