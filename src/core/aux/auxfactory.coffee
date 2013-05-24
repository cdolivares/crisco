Aux = require("#{__dirname}/aux")

###
  Class: AuxFactory

  Responsible for configuring Aux
  instances for  each domain given an application
  config.
###
class AuxFactory

  constructor: (appConfig, domains) ->
    @__appConfig = appConfig
    @__domains = domains
    @__auxes = {}

  get: (domain) ->
    console.log "Getting aux #{domain}"


module.exports = AuxFactory
