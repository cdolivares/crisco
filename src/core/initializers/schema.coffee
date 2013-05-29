###
  Class: SchemaInitializer

  Responsible for initializing the dojodatabase and exposing both the drivers
  and graph to the client.
###

Database = require("database")


class SchemaInitializer

  constructor: (schemaGetter, pluginGetter, dbSettingsGetter) ->
    @_sGetter          = schemaGetter
    @_pGetter          = pluginGetter
    @_dbSettingsGetter = dbSettingsGetter

  init: (clbk) ->
    _plugins = @_pGetter.get()
    _db = new Database(@_sGetter.path, @_dbSettingsGetter.path).init()

    for pluginName, plugin of _plugins
      _db.registerPlugin pluginName, plugin

    _db.connect (err, criscoDatabase) =>
      if err?
        console.error "Some error handler here"
        clbk(err)
      else
        @_criscoDatabase = criscoDatabase
        clbk(null)

  @::__defineGetter__ 'database', () ->
    return @_criscoDatabase

module.exports = SchemaInitializer
