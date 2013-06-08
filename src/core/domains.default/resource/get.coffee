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
  constructor: (crisco, r) ->
    @__c = crisco
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

    #defer this to the client!
    clientClbk = @__c.getMiddleware("resource:default:get")
    if not clientClbk?
      Aux.error "No default get logic supplied by client. Skipping..."
      return next()
    rootNode = CriscoModel.getRoot()
    p = CriscoModel.getParam(rootNode.alternateName)
    #let's find the root node and use that as the starting point.
    drivers = CriscoModel.database.drivers
    drivers["#{rootNode.name}"].findById p, (err, result) =>
      if err?
        Aux.error err
      else
        arr = CriscoModel.targets().reverse()
        #slice off the rest of the array after the rootNode and
        #follow ownership path from there.
        nArr = arr.slice(arr.indexOf(rootNode.alternateName) + 1)
        o =
          ownerDocs: result
          target: nArr.shift()
        nArr.unshift(o)
        find = (memo, dataObj, callback) =>
          clbk = (err, docs) ->
            if err?
              callback err, null
            else
              callback null, _.extend(memo, docs)
          clientClbk.call(clientClbk, CriscoModel, Aux, dataObj.ownerDocs, dataObj.target, clbk)
        async.reduce nArr, {}, find, (err, result) ->
          Aux.res.send 200, {data: result}

  @::__defineGetter__ 'route', () ->
    @__r.route

module.exports = GET
