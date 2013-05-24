###
  Class: CriscoModelFactory

  Responsible for configuring CriscoModel
  instances for  each domain given an application
  config.
###

class CriscoModelFactory

  ###
    Method: constructor

    @param appConfig {Object} - A Crisco Application Configuration
    @param domains {Object} -
      {
        ADomainName: ["array of domain configs"]
      }
  ###

  constructor: (appConfig, domains, database) ->
    @__appConfig = appConfig
    @__domains = domains
    @__database = database
    @__criscoModels = {}

  get: (domain) ->
    console.log "Getting domain #{domain}"



module.exports = CriscoModelFactory
