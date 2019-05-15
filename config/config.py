import os
file_path = os.path.realpath(__file__)
dir_path = os.path.dirname(file_path)

def get_config():
  conf = {}
  conf['global'] = {}
  conf['global']['root'] = os.path.abspath(
    os.path.join(dir_path, os.pardir)
  )
  conf['global']['image_tag'] = 'lexatnet/lexet'
  conf['global']['user_id'] = os.getuid()
  conf['global']['group_id'] = conf['global']['user_id']

  conf['ssh'] = {}
  conf['ssh']['lexet_key_name'] = 'key'
  conf['ssh']['lexet_ssh_host_rsa_key_name'] = 'ssh_host_rsa_key'
  conf['ssh']['lexet_ssh_host_dsa_key_name'] = 'ssh_host_dsa_key'
  conf['ssh']['lexet_ssh_host_ecdsa_key_name'] = 'ssh_host_ecdsa_key'
  conf['ssh']['sshd_config'] = 'sshd_config'
  conf['ssh']['through_script'] = 'through-script.sh'

  build_root = os.path.abspath('build')
  conf['docker'] = {}
  conf['docker']['through_point'] = '/lexet'

  conf['docker']['build'] = {}
  conf['docker']['build']['docker_file'] = os.path.join(
    conf['global']['root'],
    'docker',
    'Dockerfile'
  )
  conf['docker']['build']['sshd_port'] = '2222'
  conf['docker']['build']['build_root'] = '/build'
  conf['docker']['build']['build_script'] = os.path.join(
    conf['docker']['build']['build_root'],
    'docker',
    'init.sh'
  )
  conf['docker']['build']['entrypoint_script'] = os.path.join(
    conf['docker']['build']['build_root'],
    'docker',
    'entrypoint.sh'
  )
  conf['docker']['build']['dist_point'] = conf['docker']['build']['build_root']
  conf['docker']['build']['volume'] = '{}-volume'.format(conf['global']['image_tag'])
  conf['docker']['build']['nvm_root'] = os.path.join(
    conf['docker']['through_point'],
    'env',
    'nvm'
  )
  conf['docker']['build']['rbenv_root'] = os.path.join(
    conf['docker']['through_point'],
    'env',
    'rbenv'
  )

  conf['docker']['run'] = {}
  conf['docker']['run']['mount_point'] = '/project'
  conf['docker']['run']['emacs_config'] = '.emacs'
  conf['docker']['run']['env_config'] = os.path.join(
    conf['global']['root'],
    'config',
    'env-config.sh'
  )
  conf['docker']['run']['ctags_exclude_config'] = 'ctags-exclude.list'
  conf['docker']['run']['lexet_tmp_dir_name'] = 'lexet-tmp'
  conf['docker']['run']['lexet_tmp_dir'] = os.path.join(
    conf['docker']['through_point'],
    conf['docker']['run']['lexet_tmp_dir_name']
  )

  conf['install'] = {}
  conf['install']['install_lexet_name'] = 'lexet'
  conf['install']['install_lexetx_name'] = 'lexetx'
  conf['install']['install_lexetx_ssh_name'] = 'lexetxs'
  conf['install']['install_dir'] = '/usr/local/bin'
  conf['install']['install_point_lexet'] = os.path.join(
    conf['install']['install_dir'],
    conf['install']['install_lexet_name']
  )
  conf['install']['install_point_lexetx'] = os.path.join(
    conf['install']['install_dir'],
    conf['install']['install_lexetx_name']
  )
  conf['install']['install_point_lexetx_ssh'] = os.path.join(
    conf['install']['install_dir'],
    conf['install']['install_lexetx_ssh_name']
  )

  conf['environment'] = {}
  conf['environment']['storage'] = '/storage'
  conf['environment']['workdir'] = conf['docker']['run']['mount_point']
  conf['environment']['label'] = conf['global']['image_tag']
  conf['environment']['lexet_external_root'] = '~/.lexet'
  conf['environment']['lexet_home_dir_name'] = 'home'
  conf['environment']['lexet_server_dir_name'] = 'server'
  conf['environment']['lexet_project_dir_name'] = '.project'
  conf['environment']['lexet_vendor_packages_dir_name'] = 'lexet-vendor-packages'
  conf['environment']['lexet_packages_dir_name'] = 'lexet-packages'
  conf['environment']['lexet_utils_dir_name'] = 'lexet-utils'
  conf['environment']['entrypoint_sshd'] = 'entrypoint-run-sshd.sh'
  conf['environment']['entrypoint_init'] = 'entrypoint-init-lexet.sh'
  conf['environment']['entrypoint_run_lexet'] = 'entrypoint-run-lexet.sh'

  return conf

config = get_config()
