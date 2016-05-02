module.exports = (grunt) ->

  # Automatically loads all Grunt tasks
  require('load-grunt-tasks')(grunt)

  grunt.initConfig
    curl:
      grav:
        src: 'https://github.com/getgrav/grav/releases/download/1.0.10/grav-admin-v1.0.10.zip'
        dest: '.tmp/grav-admin.zip'
    unzip:
      grav:
        src: '.tmp/grav-admin.zip'
        dest: '.tmp/'
    watch:
      styles:
        files: ['src/**']
        tasks: ['copy:main']
      bower:
        files: ['bower.json', 'bower_components/*']
        tasks: ['bower_install', 'bower_concat']
    mkdir:
      all:
        options:
          create: ['src']
    copy:
      main:
        files: [
          {
            expand: true
            cwd: 'src/'
            src: '**'
            dest: 'dist/'
            dot: true
          }
        ]
      grav_install:
        files: [{
          expand: true
          cwd: '.tmp/grav-admin'
          src: '**'
          dest: 'dist/'
          dot: true
        }]
    clean:
      main: [
        '.tmp'
      ]
      gravPostInstall: [
        'dist/webserver-configs/'
        'dist/**/.gitkeep'
        'dist/CHANGELOG.md'
        'dist/CONTRIBUTING.md'
        'dist/README.md'
        'dist/LICENSE.txt'
      ]

  grunt.registerTask 'grav_install', 'Downloads Grav_Admin and installs Grav_Admin', ->
    if grunt.file.exists('dist/index.php') isnt true
      grunt.task.run ['curl:grav', 'unzip:grav', 'copy:grav_install', 'clean']

  grunt.registerTask 'install', ['bower_install', 'grav_install']
  grunt.registerTask 'build', ['install', 'clean:main', 'copy:main', 'mkdir']
  grunt.registerTask 'default', ['build', 'watch']
