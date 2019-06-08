import logging
import os
import sys
from lib import LexetConfig
from lib import LexetBuilder
from lib import LexetInstaller
from lib import LexetUninstaller
from lib import LexetStarter
from lib import LexetArgumentParser

file_path = os.path.realpath(__file__)
dir_path = os.path.dirname(file_path)
root = os.path.abspath(
  os.path.join(
    dir_path,
    os.pardir
  )
)


class Lexet():
  def __init__(self, args):
    self.parseArgs(args)
    self.configure()

  def parseArgs(self, args):
    parser = LexetArgumentParser()
    self.args = parser.parse_args(args)
    self.argsParsed = True

  def configure(self):
    self.config = LexConfig(self.args.config)

  def install(self):
    installer = LexetInstaller(self.config)
    installer.install()

  def uninstall(self):
    uninstaller = LexetUninstaller(self.config)
    uninstaller.uninstall()

  def run(self):
    project_path = self.args.project
    self.project = LexetProject(self.config, project_path)
    starter = LexetStarter(self.config, self.project)
    starter.start()

  def runAction(self):
    action = self.args.action
    getattr(self, action)()


def main():
  args = sys.argv
  lexet = Lexet(args)
  lexet.runAction()

if __name__ == "__main__":
    # execute only if run as a script
    main()
