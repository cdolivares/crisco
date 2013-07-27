async = require("async")
myAsync = require("#{__dirname}/../../../helpers/async")
_ = require("underscore")

class GET
  ###
      Where a route object, r, is defined as:
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
          if clbk?
            clbk () ->
              next()
          else
            Aux.response.send()
            next()
      else
        next()

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
    if not p?
      #this case is when we're trying to get the rootNode
      q = {}
      q["_#{Aux.me._type_}._id"] = Aux.me._id
      # q["_#{Aux.me._type_}.l"]= {$gt: 0}
      CriscoModel.database.drivers["#{rootNode.name}"].find q, (err, result) =>
        if err?
          Aux.error err.stack
          Aux.response.status(500).message(err.message).send()
        else
          r = _.filter result, (e) -> #HACK to filter out rejected resources for now!
            for p in e["_#{Aux.me._type_}"] by 1
              if p._id is Aux.me._id
                return p.l >= 0
          Aux.response.success().pack(r).send()
    else
      drivers = CriscoModel.database.drivers
      drivers["#{rootNode.name}"].findById p, (err, result) =>
        if err?
          Aux.error err
        else
          targets = CriscoModel.targets()
          arr = targets.slice(0).reverse()
          #slice off the rest of the array after the rootNode and
          #follow ownership path from there.
          nArr = arr.slice(arr.indexOf(rootNode.alternateName) + 1)
          memo = {}
          previousCollection = rootNode.alternateName
          memo[previousCollection] = [result]
          find = (memo, collection, callback) =>
            clbk = (err, docs) ->
              previousCollection = collection
              if err?
                callback err, null
              else
                callback null, _.extend(memo, docs)
            parent =
              collection: previousCollection
              result: memo[previousCollection]
            child =
              collection: collection
              id: CriscoModel.getParam(collection)
            clientClbk.call(clientClbk, CriscoModel, Aux, parent, child, clbk)
          async.reduce nArr, memo, find, (err, result) ->
            if not err?
              r = _.pick result, targets[0]
              r = r[Object.keys(r).shift()]
              ###
                Let's unpack the result of getChildren from
                the namespaced model collection.
              ###
              Aux.response.success().pack(r)
              Aux.info.set 'default:get', r
              next()

  @::__defineGetter__ 'route', () ->
    @__r.route

module.exports = GET
