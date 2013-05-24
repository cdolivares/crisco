###
  Class: ActionCollector  aka. "Factory"

  Collects Action level configurations and carries out
  the appropriate operations to add them to an initialized
  express instance.

###
ActionDomain = require("#{__dirname}/../domains/action")


class ActionCollector

  constructor: (express) ->
    @_e = express
    @_actions = {}

  ###
    Method: add
    
    Adds an actionDomain to the ActionDomain collection.
    
    @param "string" that's the name of this particular domain
    @param "object" describing the state of the action domain
  ###

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
