module.exports = (CriscoModels, Aux, next) ->
  console.log "Running Permission Middleware"
  targets = CriscoModels.targets()
  nodeManager = CriscoModels.database.nodeManager
  for target in targets
    node = nodeManager.find target
    if node.isRoot
      CriscoModels.populate (err, models) =>
        next()
    else
      console.error "Could not find a root for permissions please check route #{Aux.req.url}"
      next()
