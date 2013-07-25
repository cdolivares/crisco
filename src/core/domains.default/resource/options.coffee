class OPTIONS

  constructor: (crisco, r) ->
    @__c = crisco
    @__r = r

  handler: (req, res, next) =>
    CriscoModel = req.__crisco.model
    Aux = req.__crisco.aux
    @__r.handler CriscoModel, Aux, (runDefault=false, clbk) =>
      #require users to call this function and pass in some
      #optional flag for 
      next()

  @::__defineGetter__ 'route', () ->
    @__r.route

module.exports = OPTIONS
