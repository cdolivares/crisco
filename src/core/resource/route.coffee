CriscoResourceHandler = require("#{__dirname}/../router/")

###
  Class: CriscoResourceRoute

  Responsible for taking a resource route configuration
  and exporting an appropriately configured CriscoResourceHandler
  into the Crisco route application space.
###

class CriscoResourceRoute

  ###
    Method: constructor

    Takes a resource route config which looks like
      {
        tag: "Tag",
        route: "Route",
      }
  ###
  constructor: (config) ->
    @_c = config

  build: () ->
    console.log "Building action route..."

  enrich: (express, clbk) ->
    console.log "Enriching crisco resource route"

module.exports = CriscoResourceRoute
