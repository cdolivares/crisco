###
  Class: ActionCollector

  Collects Action level configurations and carries out
  the appropriate operations to add them to an initialized
  express instance.

###
ResourceDomain = require("#{__dirname}/../domains/action")


class ResourceCollector

  constructor: (express) ->
    @_e = express
    @_resources = {}

  add: () ->

  get: (name) ->
    if name?
      return @_resources[name]
    else
      return @_resources



module.exports = ResourceCollector
