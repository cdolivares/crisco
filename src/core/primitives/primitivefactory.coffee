###
  Class: Primitive Factory

  Handles initializing new Crisco Primitives.
###


class PrimitiveFactory

  constructor: (appConfig, domainConfig, database) ->
    @__configs =
      app: appConfig
      domain: domainConfig
    @__database = database
    @__primitives = {}

  registerPrimitive: (name, P) ->
    P.config @__configs.app, @__configs.domain, @__database
    @__primitives[name] = P

  getPrimitive: (name, domain, req, res) ->
    P = @__primitives[name]
    if not P?
      return null
    return  P.init(domain, req, res)

module.exports = PrimitiveFactory
