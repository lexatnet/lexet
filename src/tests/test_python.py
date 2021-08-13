import sys
import os

def test_pyhton(capsys):
  os.system(' '.join([
    'python',
    '--version'
  ]))
  captured = capsys.readouterr()
  assert captured.out.find('Python 3.9')


def test_pylint(capsys):
  os.system(' '.join([
    'pylint',
    '--version'
  ]))
  captured = capsys.readouterr()
  assert captured.out.find('pylint 2.9')
