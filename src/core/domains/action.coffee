###
  Class: ActionDomain

  Responsible for configuring an express
  server instance with a single action
  domain.
###

class ActionDomain

  constructor: (express, config) ->
    @_e = express
    @_c = config

  enrich: () ->
    console.log "Enriching an Action..."

    #for each action route find
    
      #before middleware

      #register route with express instance and pass
      # criscoModel, aux, and default implementation back
      # to client registered callback


module.exports = ActionDomain
