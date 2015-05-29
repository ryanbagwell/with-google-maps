withGoogleMaps = require '../dist/index'
assert = require 'assert'

describe 'MochaTests', ->

    it 'should load the google maps library with a valid api key', (done) ->

        @timeout 5000

        withGoogleMaps("#{GOOGLE_MAPS_API_KEY}").then( ->
            assert(google, 'Google Maps API should be loaded with valid api key')
            done()
        ).done()

    it 'should fail without an api key', (done) ->

        @timeout 5000

        withGoogleMaps().then( ->
            console.log arguments

        ).fail( (err) ->
            assert(err, 'Sequence should fail if API key is not specified')
            done()
        ).done(
            assert(true, 'Sequence should fail if API key is not specified')
            done()
        )


