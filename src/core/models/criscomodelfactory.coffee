CriscoModel = require("#{__dirname}/criscomodel")

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

  constructor: (appConfig, database) ->
    @__appConfig = appConfig
    @__database = database
    @__criscoModels = {}

  get: (domain) ->
    console.log "Getting CriscoModel for domain #{domain}"
    r =
      init: (req) =>
        #extract route info here.
        routeInfo =
          route:  req.route
          method: req.method
          query:  req.query
          body:   req.body
        return new CriscoModel(domain, @__database, routeInfo)
    return r


module.exports = CriscoModelFactory
