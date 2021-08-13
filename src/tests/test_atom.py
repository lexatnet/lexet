import sys
import os

def test_pyhton(capsys):
  os.system(' '.join([
    'atom',
    '--version'
  ]))
  captured = capsys.readouterr()
  assert captured.out.find('Atom    : 1.57')
  assert captured.out.find('Electron: 9.4')
  assert captured.out.find('Chrome  : 83')
  assert captured.out.find('Node    : 12')
