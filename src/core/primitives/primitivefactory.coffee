###
  Class: Primitive Factory

  Handles initializing new Crisco Primitives:
    -CriscoModel
    -CriscoAction
    -Aux
###


class PrimitiveFactory

  ###
    Method: constructor

    @param - appConfig - Application level configurations
             defined on Crisco.
    @param - domainConfig - An object containing all the
             serialized action and resource domain
             configurations
    @param - database - instance of database
  ###

  constructor: (crisco, domainConfig, database) ->
    @__configs =
      app: crisco.appConfig
      domain: domainConfig
    @__database = database
    @__primitives = {}

  registerPrimitive: (name, P) ->
    P.config @__configs.app, @__configs.domain, @__database
    @__primitives[name] = P

  ###
    should be generalized to (name, domain, routeInfo) where req, res
    are simply properties on routeInfo.
  ###
  getPrimitive: (name, domain, routeInfo) ->
    P = @__primitives[name]
    if not P?
      return null
    return  P.init(crisco, domain, routeInfo)

module.exports = PrimitiveFactory
