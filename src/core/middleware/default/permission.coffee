module.exports = (CriscoModels, Aux, next) ->
  console.log "Running Permission Middleware"
  deny = () ->
    Aux.res.json 401, {message: "Not Authorized"}
  targets = CriscoModels.targets()
  nodeManager = CriscoModels.database.nodeManager
  for target in targets
    node = nodeManager.find target
    if node.isRoot
      return CriscoModels.populate (err, models) ->
        t = models[node.name]
        me = Aux.me
        #check permissions here...
        v = Crisco.getMiddleware "verify:permission"
        if not v?
          console.error "-------------------------"
          console.error "No permission verification handler registered:"
          console.error "    -url: #{Axu.req.url}"
          console.error "-------------------------"
          return deny()
        o =
          type: Aux.req.method
          actor: me
          target: t
          database: CriscoModels.database
        v o, (auth) ->
          if auth
            next()
          else
            deny()

  console.error "Could not find a root for permissions please check route #{Aux.req.url}"
  deny()
