###
  Application Initializers
###

SchemaInitializer = require("#{__dirname}/schema")
RouteInitializer = require("#{__dirname}/route")

###
  Action and Resource Collectors
###
ActionCollector = require("#{__dirname}/../collectors/action")
ResourceCollector = require("#{__dirname}/../collectors/resource")

Express = require("express")

class AppInitializer

  ###
    Method: constructor


  ###
  constructor: (actionsG, resourcesG, schemasG, pluginsG, dbSettingsG) ->
    @_s = schemasG
    @_r = resourcesG
    @_p = pluginsG
    @_a = actionsG
    @_dbSettings = dbSettingsG
    @_initializers = {}
    @_e = Express()

  init: (clbk) ->

    resourceCollector = new ResourceCollector(@_e)
    actionCollector = new ActionCollector(@_e)

    @_initializers.schema   = new SchemaInitializer(@_s, @_p, @_dbSettings)
    @_initializers.resource = new RouteInitializer(@_r, resourceCollector)
    @_initializers.action   = new RouteInitializer(@_a, actionCollector)

    @_init (err) =>
      if err?
        console.error "Error In Application Initialization"
        console.error err.message
      else
        @_initializers.resource.enrich()
      #loaders initialized...

  _init: (clbk) ->
    @_initializers.schema.init (err) =>
      @_initializers.resource.init (err) =>
        @_initializers.action.init (err) =>
          clbk null


module.exports = AppInitializer
