class ResourceInitializer

  constructor: (resourceGetter) ->
    @_resourceGetter = resourceGetter

  init: (clbk) ->
    @_resourceGetter.init()
    clbk()

  enrich: (express, clbk) ->
    ResourceConfigurations = @_resourceGetter.get()
    for rName, config of ResourceConfigurations
      console.log "Enriching resource...", rName
      console.log config.serialize()
      #for each resource group initialize
      #a CriscoResource handler

module.exports = ResourceInitializer
