class PUT

  constructor: (crisco, r) ->
    @__c = crisco
    @__r = r

  handler: (req, res, next) =>

  @::__defineGetter__ 'route', () ->
    @__r.route

module.exports = PUT
