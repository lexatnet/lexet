from shutil import copyfile
import os
from pathlib import Path

file_path = Path(__file__).resolve()
dir_path = file_path.parent()
root = Path(
  dir_path,
  os.pardir,
  os.pardir
).resolve()

class LexetHome():
  def __init__(self, home):
    self.home = home

  def exists(self):
    return os.path.exists(self.home)

  def create(self):
    self.create_home_dir()
    self.init_config()

  def create_home_dir(self):
    command_parts = ['mkdir']
    command_parts.append('--parent')
    command_parts.append('--verbose')
    command_parts.append(self.home)
    os.system(' '.join(command_parts))

  def init_config(self):
    self.copy_config_template()
    self.copy_emacs_config()

  def copy_config_template(self):
    copyfile(
      Path(
        root,
        'lexet',
        'config'
      ),
      Path(
        Path.home(),
        '.lexet-new',
        'config'
      ),
    )

  def copy_emacs_config(self):
    copyfile(
      Path(
        root,
        'config',
        '.emacs'
      ),
      Path(
        Path.home(),
        '.lexet-new',
        '.emacs'
      ),
    )
