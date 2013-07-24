_ = require("underscore")

module.exports = (CriscoModels, Aux, next) ->
  console.log "Running Feature Flag Middleware"
  deny = () =>
    Aux.response.status(401).message("Not Authorized").send()
  if not (root = CriscoModels.getRoot())?
    console.log "Cannot find root node. Denying..."
    deny()
  else
    #if root configuration has featureFlags defined
    console.log "Checking root configuration", root.configuration
    if not root.configuration.featureFlags?
      console.log "Route #{Aux.req.originalUrl} does not have featureFlags. Skipping..."
      next()
    else
      resourceId = CriscoModels.getParam(root.alternateName)
      Aux.me.getFeatureFlags root.name, {_id: resourceId}, (featureFlags) =>
        console.log "Teacher feature flags", featureFlags
        confFlags = root.configuration.featureFlags
        if _.isEmpty(_.difference(confFlags, featureFlags))
          next()
        else
          deny()
