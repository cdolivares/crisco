SchemaInitializer = require("#{__dirname}/schema")
ResourceInitializer = require("#{__dirname}/resource")
ActionInitializer = require("#{__dirname}/action")


class AppInitializer

  ###
    Method: constructor


  ###
  constructor: (schemas, resources, plugins, dbSettings, actions) ->
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

    _schema.init (err) =>
      _resource.init (err) =>
        _action.init (err) =>

module.exports = AppInitializer
