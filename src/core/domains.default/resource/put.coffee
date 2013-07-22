class PUT

  constructor: (crisco, r) ->
    @__c = crisco
    @__r = r

  handler: (req, res, next) =>
    CriscoModel = req.__crisco.model
    Aux = req.__crisco.aux
    @__r.handler CriscoModel, Aux, (runDefault=false, clbk) =>
      #require users to call this function and pass in some
      #optional flag for 
      if runDefault
        console.log "Running default PUT handler..."
        @_default CriscoModel, Aux, () ->
          if clbk?
            clbk () ->
              next()
          else
            Aux.send()
            next()

  _default: (CriscoModel, Aux, next) ->
    clientClbk = @__c.getMiddleware("resource:default:put")
    if not clientClbk?
      Aux.error "No default post logic supplied by client. Skipping..."
      return next()
    targets = CriscoModel.targets()
    targetCollection = targets[0]
    targetNode = CriscoModel.database.nodeManager.find(targetCollection)

    TargetModel = CriscoModel.database.drivers[targetNode.name]
    ###
      Need to remap properties to canonical names if database field
      rename has been used.
    ###

    targetObject =
      collection: targetCollection
      id: CriscoModel.getParam(targetCollection)
      properties: TargetModel.unmap(Aux.body)

    clientClbk CriscoModel, Aux, targetObject, (err, result) ->
      if err?
        Aux.response.status(500).message(err.message).send()
      else
        Aux.response.success().pack(result).send()

  @::__defineGetter__ 'route', () ->
    @__r.route

module.exports = PUT
