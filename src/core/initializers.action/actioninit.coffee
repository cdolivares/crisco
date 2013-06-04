CriscoActionInit =
    require("#{__dirname}/../middleware.action/init")

class ActionConditioner

  constructor: (database) ->
    @__db = database
    @__actionInit = new CriscoActionInit(@__db)
    @__actionInit.init()



  ###
    Method: get

    Returns an array of express compliant middleware that
    initializes Crisco primitives. For now Actions
    aren't separated into domains like resources...
  ###
  get: () ->
    return @__actionInit.getExpressMiddleware()

module.exports = ActionConditioner
