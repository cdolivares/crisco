async = require("async")

class GET
  ###
      Where a route object is defined as:
      {
        tag: "routeTag"
        route: "/route"
        method: "GET|PUT|POST|DEL"
        handler: RouteFn
      }
  ###
  constructor: (r) ->
    @__r = r

  handler: (req, res, next) =>
    CriscoModel = req.__crisco.model
    Aux = req.__crisco.aux
    @__r.handler CriscoModel, Aux, (runDefault=false) =>
      #require users to call this function and pass in some
      #optional flag for 
      if runDefault
        console.log "Running default GET handler..."
        @_default CriscoModel, Aux, () ->
          #done

  ###
    Method: _default 
    
    Implementation lives here for now, but follows the
    same convention as any other CriscoMiddleware. No
    reason client can't override this functionality.
  ###

  _default: (CriscoModel, Aux, next) =>
    rootNode = CriscoModel.getRoot()
    p = CriscoModel.getParam(rootNode.alternateName)
    #let's find the root node and use that as the starting point.
    drivers = CriscoModel.database.drivers
    drivers["#{rootNode.name}"].findById p, (err, result) =>
      if err?
        Aux.error err
      else
        arr = CriscoModel.targets().reverse()
        nArr = arr.slice(arr.indexOf(rootNode.alternateName))
        find = (memo, collItem, callback) =>
          node = CriscoModel.find(collItem)
          id = CriscoModel.getParam(collItem)
          CriscoModel.database.drivers.findById id
        async.reduce nArr, [result], find, (err, result) ->
          #TODO: Finish this...

  @::__defineGetter__ 'route', () ->
    @__r.route

module.exports = GET
