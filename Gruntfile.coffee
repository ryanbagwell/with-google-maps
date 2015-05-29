path = require 'path'
webpack = require 'webpack'

module.exports = (grunt) ->
  _ = grunt.util._

  # Project configuration.
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    webpack:
      options:
        cache: true
        devtool: 'sourcemap'
        output:
          path: "dist/"
          filename: "[name].js"
        resolve:
          extensions: ['.coffee', '.js', '']
          modulesDirectories: [
            'node_modules'
            'src'
            'test'
          ]
        module:
          loaders: [
            {test: /\.coffee$/, loaders: ['coffee-loader']}
          ]
        stats:
          colors: true
          modules: true
          reasons: true
        failOnError: false

      production:
        watch: false
        keepalive: false
        entry:
          "index":"index"
        output:
          libraryTarget: "commonjs2"

      test:
        entry:
          "test":"test"
        output:
          path: "test/"
          filename: "[name].js"
          libraryTarget: "var"
        plugins: [
          new webpack.DefinePlugin(
            GOOGLE_MAPS_API_KEY: JSON.stringify(process.env.GOOGLE_MAPS_API_KEY)
          )
        ]


    bump:
      options:
        pushTo: 'origin'
        files: ['package.json']
        syncVersions: true
        commitFiles: ['dist/*', 'src/*', '.gitignore', './*.{json,md,coffee,js}', './LICENSE']

    karma:
      options:
        configFile: 'karma.conf.js'
        files: [
          'test/test.js'
          'test/results.html'
        ]

      dev:
        #On our local environment we want to test all the things!
        browsers: ['Chrome', 'Firefox', 'PhantomJS']


      # // For production, that is to say, our CI environment, we'll
      # // run tests once in PhantomJS browser.
      prod:
        singleRun: true
        browsers: ['PhantomJS']




    #Load grunt plugins
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-bump'
    grunt.loadNpmTasks 'grunt-webpack'
    grunt.loadNpmTasks 'grunt-karma'

    # Define tasks.
    grunt.registerTask 'build', ['webpack:production']
    grunt.registerTask 'test', ['webpack:production', 'webpack:test']
    grunt.registerTask 'default', ['build']