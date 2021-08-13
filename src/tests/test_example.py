import sys
import os

def test_example(capsys):
  print("hello")
  sys.stderr.write("world\n")
  captured = capsys.readouterr()
  assert captured.out == "hello\n"
  assert captured.err == "world\n"
  print("next")
  captured = capsys.readouterr()
  assert captured.out == "next\n"


def test_experiment():
  print("hello")
  os.system(' '.join([
    'whereis',
    'bash'
  ]))
