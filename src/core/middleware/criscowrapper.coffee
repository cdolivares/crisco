###
  Explain this...
###

class CriscoWrapper

  constructor: (fn) ->
    @__fn = fn

  handler: () =>
    return (req, res, next) =>
      CriscoModel = req.__crisco.model
      Aux = req.__crisco.aux
      @__fn CriscoModel, Aux, () =>
        next()

module.exports = CriscoWrapper
