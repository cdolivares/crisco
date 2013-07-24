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
    if not root.configuration.featureFlags? or not Aux.routeInfo.featureFlags?
      console.log "Route #{Aux.req.originalUrl} does not have featureFlags. Skipping..."
      next()
    else
      #verify that flags on this route are all defined in the root resource config.
      resourceFF = root.configuration.featureFlags
      routeFF = Aux.routeInfo.featureFlags
      if not _.intersection(Object.keys(resourceFF), routeFF).length is routeFF.length  #bad feature flag
        console.error "Root resource #{root.name} does not contain all feature flags #{routeFF}. Skipping..."
        next()
      else
        resourceId = CriscoModels.getParam(root.alternateName)
        v = Aux.crisco.getMiddleware "verify:featureFlags"
        if not v?
          console.log "Client did not register a verify:featureFlags callback. Skipping..."
          next()
        else
          v CriscoModels, Aux, root.name, {_id: resourceId}, (featureFlags) =>
            console.log "Teacher feature flags", featureFlags
            if _.intersection(routeFF, featureFlags).length is routeFF.length
              next()
            else
              deny()
