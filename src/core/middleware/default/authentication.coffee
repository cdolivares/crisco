module.exports = (CriscoModels, Aux, next) ->
  console.log "Running Authentication Middleware"
  next()