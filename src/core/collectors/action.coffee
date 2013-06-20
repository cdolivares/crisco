###
  Class: ActionCollector

  Collects Action level configurations and carries out
  the appropriate operations to add them to an initialized
  express instance.

###
ActionDomain = require("#{__dirname}/../domains/action")


class ActionCollector

  constructor: (crisco, express, actionInitializer) ->
    @__c  = crisco
    @__e  = express
    @__a = actionInitializer
    @__actions = {}

  ###
    Method: add
    
    Adds an actionDomain to the ActionDomain collection.
    
    @param "string" that's the name of this particular domain
    @param "object" describing the state of the action domain
  ###

  add: (name, config) ->
    ad = new ActionDomain(@__c, @__e, config, @__a)
    ad.enrich()
    @__actions[name] = ad

  get: (name) ->
    if name?
      return @__actions[name]
    else
      return @__actions

module.exports = ActionCollector
