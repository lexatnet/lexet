const gulp = require('gulp');
const { get } = require('lodash');
const { writeFile }  = require('fs/promises');
const fs = require('fs-extra');
const config = require('@config');
const iniDir = get(config, 'php.iniDir');
const iniDest = get(config, 'php.iniDest');


gulp.task('prepare-php-ini', async () => {
  const content = [
    'extension_dir=${LEXET_MOUNT_POINT}/usr/php/extensions',
    'extension = opcache.so',
    // 'extension = xmlwriter.so',
    // 'extension = json.so',
    // 'extension = tokenizer.so',
    // 'extension = simplexml.so',
    // 'extension = iconv.so',
    // 'extension = mbstring.so',
  ].join('\n');

  try {
    await fs.ensureDir(iniDir);
    await writeFile(iniDest, content);
  } catch (err) {
    // eslint-disable-next-line no-console
    console.log(err);
  }
});
