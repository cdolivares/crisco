###
  Class: ActionDomain

  Responsible for configuring an express
  server instance with a single action
  domain.
###

class ActionDomain

  constructor: (express, config, database) ->
    @__e = express
    @__c = config
    @__d = database

  enrich: () ->
    console.log "Enriching an action"
    #for each action route find
    
      #before middleware

      #register route with express instance and pass
      # criscoModel, aux, and default implementation back
      # to client registered callback


module.exports = ActionDomain
