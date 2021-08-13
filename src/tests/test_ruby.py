import sys
import os

def test_ruby(capsys):
  os.system(' '.join([
    'ruby',
    '--version'
  ]))
  captured = capsys.readouterr()
  assert captured.out.find('ruby')
