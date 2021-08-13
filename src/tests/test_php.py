import sys
import os

def test_php(capsys):
  os.system(' '.join([
    'php',
    '--version'
  ]))
  captured = capsys.readouterr()
  assert captured.out.find('PHP 8.1')
