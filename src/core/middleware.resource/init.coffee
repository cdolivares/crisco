###
  A collection of the first N
  steps of Crisco initialization.
###

## TODO(chris)! Replace with new PrimitiveFactory
CriscoModels = require("#{__dirname}/../models/criscomodelfactory")

###
 Let's just define the ordered middleware here. Bind each
 anonymous function to this context so it get's access
###

Middleware =
  ###
    Step 1:

    -Create a namespaced __crisco variable
    container on the express req object.

    -Call user registered deserializer
    if it exists.
  ###
  '1': (domain) ->
    return (req, res, next) =>
      req.__crisco = {}
      h = (me) =>
        if me?
          req.__crisco.me = me
        next()
      m = Crisco.getMiddleware "deserialize"
      if m?
        m.call(m, req, res, @__db, h)
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
  '2': (domain) ->
    return (req, res, next) =>
      console.log "Initializing Crisco Models Primitives"
      cm = @__CriscoModels.get(domain)
      req.__crisco.model = cm.init(req)
      aux = #simplified aux object for now.
        req: req
        res: res
        log: console.log
        error: console.error
        me: req.__crisco.me
      req.__crisco.aux = aux
      next()

class CriscoResourceInit

  constructor: (database, appConfig) ->
    @__db = database
    @__CriscoModels = new CriscoModels appConfig, @__db

  init: () ->
    #let's bind each middleware to THIS instance
    for step, route of Middleware
      Middleware[step] = route.bind(@)
    # clbk null

  getExpressMiddleware: (domain) ->
    return [
      Middleware['1'](domain),
      Middleware['2'](domain)
    ]

module.exports = CriscoResourceInit
