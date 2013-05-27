###
  A collection of the first N
  steps of Crisco initialization.
###

CriscoModels = require("#{__dirname}/../../models/criscomodelfactory")


###
  Step 1:

  -Create a namespaced __crisco variable
  container the express req object.

  -Call user registered deserializer
  if it exists.
###
exports.one = (req, res, next) ->
  req.__crisco = {}
  h = (me) ->
    if me?
      req.__crisco.me = me
    next()
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
exports.two = (domain) ->
  return (req, res, next) =>
    cm = CriscoModels.get('domain')
    req.__crisco.model = cm.init(req)

