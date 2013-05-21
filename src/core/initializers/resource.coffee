class ResourceInitializer

  constructor: (resourceGetter) ->
    @_resourceGetter = resourceGetter

  init: (clbk) ->
    @_resourceGetter.load (err) =>
      clbk err

  enrich: (express, clbk) ->
    ResourceConfigurations = @_resourceGetter.get()
    for config in ResourceConfigurations
      console.log "Enriching resources..."
      #for each resource group initialize
      #a CriscoResource handler

module.exports = ResourceInitializer
