CriscoResourceInit =
    require("#{__dirname}/../../middleware/default/crisco_action_init")

class ActionConditioner

  constructor: (database) ->
    @__db = database
    @__resourceInit = new CriscoResourceInit(@__db)


  get: (domain) ->
    return @__resourceInit
    return []


module.exports = ActionConditioner
