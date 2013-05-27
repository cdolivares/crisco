Aux = require("#{__dirname}/aux")

###
  Class: AuxFactory

  Responsible for configuring Aux
  instances for  each domain given an application
  config.
###
class AuxFactory

  constructor: (appConfig, domainConfigs) ->
    @__appConfig = appConfig
    @__domainConfigs = domainConfigs
    @__auxes = {}

  get: (domain) ->
    console.log "Getting aux for domain #{domain}"


module.exports = AuxFactory
