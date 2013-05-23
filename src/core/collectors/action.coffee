###
  Class: ActionCollector

  Collects Action level configurations and carries out
  the appropriate operations to add them to an initialized
  express instance.

###
ActionDomain = require("#{__dirname}/../domains/action")


class ActionCollector

  constructor: (express) ->
    @_e = express
    @_actions = {}

  add: (name, config) ->
    ad = new ActionDomain(@_e, config)
    ad.enrich()
    @_actions[name] = ad

  get: (name) ->
    if name?
      return @_actions[name]
    else
      return @_actions

module.exports = ActionCollector
