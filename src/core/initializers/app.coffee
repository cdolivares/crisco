###
  Application Initializers
###

SchemaInitializer = require("#{__dirname}/schema")
RouteInitializer = require("#{__dirname}/route")

###
  Action and Resource Collectors
###
ActionCollector = require("#{__dirname}/../action/collector")


class AppInitializer

  ###
    Method: constructor


  ###
  constructor: (schemasG, resourcesG, pluginsG, dbSettingsG, actionsG) ->
    @_s = schemas
    @_r = resources
    @_p = plugins
    @_dbSettings = dbSettings
    @_initializers = {}

  init: (clbk) ->
    @_initializers.schema = _schema =
        new SchemaInitializer(@_s, @_p, @_dbSettings)
    @_initializers.resource = _resource =
        new ResourceInitializer(@_r)
    @_initializers.action   = _action =
        new ActionInitializer(@_p)

    @__init (err) =>
      if err?
        console.error "Error In Application Initialization"
        console.error err.message
      else
        _resource.enrich()

      #loaders initialized...

  __init: (clbk) ->
    #TODO(chris): Error handle here...
    @_initializers.schema.init (err) =>
      @_initializers.resource.init (err) =>
        @_initializers.action.init (err) =>
          #construct actual express

          clbk null


module.exports = AppInitializer
