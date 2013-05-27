###
  Class: ActionCollector

  Collects Action level configurations and carries out
  the appropriate operations to add them to an initialized
  express instance.

###
ActionDomain = require("#{__dirname}/../domains/action")


class ActionCollector

  constructor: (express, conditioner) ->
    @__e  = express
    @__cond = conditioner
    @__actions = {}

  ###
    Method: add
    
    Adds an actionDomain to the ActionDomain collection.
    
    @param "string" that's the name of this particular domain
    @param "object" describing the state of the action domain
  ###

  add: (name, config) ->
    ad = new ActionDomain(@__e, config, @__cond)
    ad.enrich()
    @__actions[name] = ad

  get: (name) ->
    if name?
      return @__actions[name]
    else
      return @__actions

module.exports = ActionCollector
