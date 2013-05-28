module.exports = (CriscoModels, Aux, next) ->
  console.log "Running Authentication Middleware"
  if not Aux.me? #not authenticated
    res = Aux.res
    res.json 401, {message: "User is not authenticated. Please create a session."}
  else
    next()
