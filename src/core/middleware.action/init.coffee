###
  A collection of the first N
  steps of Crisco initialization.
###

###
 Let's just define the ordered middleware here. Bind each
 anonymous function to this context so it get's access to
 the instance variables.
###

Middleware =
  ###
    Step 1:

    -Create a namespaced __crisco variable
    container on the express req object.

    -Call user registered deserializer
    if it exists.
  ###
  '1': (crisco, domain) ->
    return (req, res, next) =>
      req.__crisco = {}
      h = (me) =>
        if me?
          req.__crisco.me = me
        next()
      m = @__c.getMiddleware "deserialize"
      if m?
        m.call(m, req, res, @__database, h)
      else
        next()

  ###
    Step 2:

    -Create CriscoModel and Aux
    instances

  # TODO(chris): Might need to curry with
    domainConfig if CriscoModel needs
    domain configurable options to bootstrap
    itself.
  ###
  '2': (domain, routeInfo) ->
    return (req, res, next) =>
      extendedRouteInfo = _.extend routeInfo, {req: req, res: res}
      ca = @__primitiveFactory.getPrimitive "CriscoAction", domain, extendedRouteInfo
      aux = @__primitiveFactory.getPrimitive "CriscoAux", domain, extendedRouteInfo
      req.__crisco.action = ca
      req.__crisco.aux   = aux
      next()


###
  Class: CriscoActionInit

  A collection of middleware
  and it's initializer that
  initialize Crisco Primitives
###
class CriscoActionInit

  constructor: (crisco, database, primitiveFactory) ->
    @__c                = crisco
    @__database         = database
    @__primitiveFactory = primitiveFactory

  init: () ->
    for step, route of Middleware
      Middleware[step] = route.bind(@)

  getExpressMiddleware: (domain, routeInfo) ->
    return [
      Middleware['1'](@__c, domain),
      Middleware['2'](domain, routeInfo)
    ]

module.exports = CriscoActionInit
