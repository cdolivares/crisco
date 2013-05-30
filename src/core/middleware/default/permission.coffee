module.exports = (CriscoModels, Aux, next) ->
  console.log "Running Permission Middleware"
  targets = CriscoModels.targets()
  nodeManager = CriscoModels.database.nodeManager
  for target in targets
    node = nodeManager.find target
    if node.isRoot
      return CriscoModels.populate (err, models) =>
        next()

  console.error "Could not find a root for permissions please check route #{Aux.req.url}"
  #respond with a 401
  Aux.res.json 401, {message: "Not authorized"}
