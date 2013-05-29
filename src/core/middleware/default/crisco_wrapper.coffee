# module.exports = (fn, default) ->
#   (req, res, next) ->
#     CriscoModel = req.__crisco.model
#     Aux = req.__crisco.aux

class CriscoWrapper

  constructor: (fn) ->
    @__fn = fn

  handler: () =>
    return (req, res, next) =>
      CriscoModel = req.__crisco.model
      Aux = req.__crisco.aux
      @__fn CriscoModel, Aux, () =>
        console.log "Deferring to next middleware..."
        next()

module.exports = CriscoWrapper
