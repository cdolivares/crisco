###
  A collection of the first N
  steps of Crisco initialization.
###

CriscoModels = require("#{__dirname}/../../models/criscomodelfactory")

###
 Let's just define the ordered middleware here. Bind each
 anonymous function to this context so it get's access
###

Middleware =
  ###
    Step 1:

    -Create a namespaced __crisco variable
    container the express req object.

    -Call user registered deserializer
    if it exists.
  ###
  '1': (req, res, next) ->
    req.__crisco = {}
    h = (me) ->
      if me?
        req.__crisco.me = me
      next()
    console.log
    m = Crisco.getMiddleware "deserialize"
    if m?
      m.call(m, req, res, h)
    else
      next()

  ###
    Step 2:

    -Create CriscoModel and Aux
    instances
  ###
  '2': (domain) ->
    return (req, res, next) =>
      console.log "Initializing Crisco Models..."
      cm = @__CriscoModels.get(domain)
      req.__crisco.model = cm.init(req)

class CriscoResourceInit

  constructor: (database) ->
    appConfig = {}
    domainConfig = {}
    @__db = database
    @__CriscoModels = new CriscoModels appConfig, domainConfig, @__db

  init: (clbk) ->
    #let's bind each middleware to THIS instance
    for num, route of Middleware
      Middleware[num] = route.bind(@)
    clbk null

  getExpressMiddleware: (domain) ->
    return [
      Middleware['1'],
      Middleware['2'](domain)
    ]

module.exports = CriscoResourceInit
