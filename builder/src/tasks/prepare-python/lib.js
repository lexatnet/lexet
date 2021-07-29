const execa = require('execa');
const config = require('@config');
const { get } = require('lodash');
const { pipeOutput } = require('@lib');
const destination = get(config, 'python3.destination');
const pythonPath = get(config, 'python3.pythonPath');
const executable = get(config, 'python3.executable');


const pythonExec = async (args) => {
  const env = {
    'PYTHONPATH': pythonPath,
    'INCLUDE': `${destination}/bin/include/pyhton3.9`
  };

  await pipeOutput(execa(
    executable,
    args,
    {
      shell: true,
      env,
    }
  ));
};


module.exports = {
  pythonExec,
};
