###
  Class: SchemaInitializer

  Responsible for initializing the dojodatabase and exposing both the drivers
  and graph to the client.
###

Database = require("database").Database


class SchemaInitializer

  constructor: (@__schema, @__plugins, @__dbSettings) ->

  init: (clbk) ->
    _db = new Database(@__schema, @__dbSettings).init()

    for pluginName, plugin of @__plugins
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
