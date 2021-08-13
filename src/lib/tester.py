import pytest
import sys
import os
import logging
from pathlib import Path

class LexetTester():
  def __init__(self, config):
    self.config = config

  def test(self, **kvargs):

    src_dir = os.path.dirname(
      os.path.dirname(
        os.path.abspath(__file__)
      )
    )



    tests_dir = Path(
      src_dir,
      'tests'
    )

    pytest_args = [
        str(tests_dir),
        f'-o cache_dir=/.pytest_cache',
        # f'-c {str(ini_path)}'
    ]

    cache_dir = kvargs.get('cache_dir')

    logging.info(f'pytest_args = {pytest_args}')
    sys.exit(pytest.main(pytest_args))
