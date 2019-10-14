import os

class LexetEnv():
  def __init__(self, config, project):
    self.config = config
    self.project = project

  def set(self):
    os.environ['lexet_vendor_packages_dir'] = 'self.config'
    os.environ['lexet_packages_dir'] = '1'
    os.environ['lexet_tmp_dir'] = '1'
    os.environ['project_name'] = '1'
    os.environ['ctags_exclude_config_path'] = '1'
