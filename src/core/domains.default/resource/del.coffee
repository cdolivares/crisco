class DEL

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
        console.log "Running default DELETE handler..."
        @_default CriscoModel, Aux, () ->
          #done

  _default: (CriscoModel, Aux, next) ->
    targets = CriscoModel.targets()
    targetCollection = targets[0]
    targetId = CriscoModel.getParam(targetCollection)
    targetNode = CriscoModel.database.nodeManager.find(targetCollection)
    TargetModel = CriscoModel.database.drivers["#{targetNode.name}"]
    TargetModel.findById targetId, (err, target) ->
      if err?
        Aux.res.send 500, {message: err.message}
      else if not target?
        Aux.res.send 404, {message: "Target not found."}
      else
        target.remove (err) ->
          if err?
            Aux.res.send 500, {message: err.message}
          else
            Aux.response.success().pack(target).send()

  @::__defineGetter__ 'route', () ->
    @__r.route

module.exports = DEL
