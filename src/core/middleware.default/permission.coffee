module.exports = (CriscoModels, Aux, next) ->
  console.log "Running Permission Middleware"
  deny = () ->
    Aux.res.json 401, {message: "Not Authorized"}
  targets = CriscoModels.targets()
  nodeManager = CriscoModels.database.nodeManager
  if (targets.length is 1)  and #this is for root resources that are also root to the user. eg. /classes
     not CriscoModels.getParam(targets[0])?
    return next()
  for target in targets by 1
    node = nodeManager.find target
    if not node?
      continue
    if node.isRoot
      return CriscoModels.populate (err, models) ->
        #alternateName is lowercased plural
        t = models[node.alternateName]
        me = Aux.me
        #check permissions here...
        v = Aux.crisco.getMiddleware "verify:permission"
        if not v?
          console.error "-------------------------"
          console.error "No permission verification handler registered:"
          console.error "    -url: #{Aux.req.url}"
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
