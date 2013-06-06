CriscoActionInit =
    require("#{__dirname}/../middleware.action/init")

class ActionInitializer

  constructor: (database, primitiveFactory) ->
    @__db = database
    @__primitiveFactory = primitiveFactory
    @__actionInit = new CriscoActionInit(@__db, primitiveFactory)
    @__actionInit.init()



  ###
    Method: get

    Returns an array of express compliant middleware that
    initializes Crisco primitives. For now Actions
    aren't separated into domains like resources...
  ###
  get: () ->
    return @__actionInit.getExpressMiddleware()

module.exports = ActionInitializer