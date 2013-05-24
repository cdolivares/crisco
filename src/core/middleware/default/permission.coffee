module.exports = (req, res, next) ->
  console.log "Running Permission Middleware"
  next()