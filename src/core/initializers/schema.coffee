###
  Class: SchemaInitializer

  Responsible for initializing the dojodatabase and exposing both the drivers
  and graph to the client.
###

Database = require("database").Database


class SchemaInitializer

  constructor: (schemaGetter, pluginGetter, dbSettingsGetter) ->
    @__sGetter          = schemaGetter
    @__pGetter          = pluginGetter
    @__dbSettingsGetter = dbSettingsGetter

  init: (clbk) ->
    _plugins = @__pGetter.get()
    _db = new Database(@__sGetter.path, @__dbSettingsGetter.path).init()

    for pluginName, plugin of _plugins
      _db.registerPlugin pluginName, plugin

    _db.connect (err, criscoDatabase) =>
      if err?
        console.error "Some error handler here"
        clbk(err)
      else
        @__criscoDatabase = criscoDatabase
        clbk(null)

  @::__defineGetter__ 'database', () ->
    return @__criscoDatabase

module.exports = SchemaInitializer
