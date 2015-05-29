load = require 'scriptjs'
Q = require 'q'

module.exports = (apiKey=null, version='3.19', sensor=false) ->

  deferred = Q.defer()

  if not apiKey
    deferred.reject new Error('Please provide a google maps api key.')
  else if window.google?.maps?
    console.log google
    deferred.resolve(window.google)
  else
    if not window.__onGoogleLoaded?
      window.__onGoogleLoaded = -> deferred.resolve(google)
    load "https://maps.googleapis.com/maps/api/js?v=#{version}&key=#{apiKey}&sensor=#{if sensor then 'true' else 'false'}&callback=window.__onGoogleLoaded"

  deferred.promise
