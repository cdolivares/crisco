class CriscoActionRoute

  constructor: (config) ->
    @_c = config

  build: () ->
    console.log "Building action route"

  enrich: (express) ->
    console.log "Enriching express instance with this route"

module.exports = CriscoActionRoute
