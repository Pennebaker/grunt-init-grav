/*
 * grunt-init-grav
 * https://github.com/Pennebaker
 *
 * Copyright (c) 2016 Pennebaker
 * Licensed under the MIT license.
 */

'use strict';

// Basic template description.
exports.description = 'Scaffolding for Grav local development.';

// Any existing file or directory matching this wildcard will cause a warning.
exports.warnOn = '*';

// The actual init template.
exports.template = function(grunt, init, done) {

  init.process({}, [
    // Prompt for these values.
    init.prompt('name'),
		init.prompt('author_name'),
		init.prompt('author_email')
  ], function(err, props) {
    // Files to copy (and process).
    var files = init.filesToCopy(props);
    // Actually copy (and process) files.
    init.copyAndProcess(files, props);
    // All done!
    done();
  });
};
