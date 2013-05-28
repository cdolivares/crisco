CriscoResourceInit =
    require("#{__dirname}/../../middleware/default/crisco_resource_init")

CriscoModels =
    require("#{__dirname}/../../models/criscomodelfactory")

###
  Class: ResourceConditioner

  Initializes a set of express compliant middleware that
  takes the raw request object and creates the Crisco
  route primitives CriscoModels and Aux 
###

class ResourceConditioner

  constructor: (database) ->
    @__db = database
    @__resourceInit = new CriscoResourceInit(@__db, Crisco.appConfig)
    @__resourceInit.init()


  ###
    Method: get

    Returns an array of express middleware
    compliant functions that create
    our crisco resource primitives
  ###
  get: (domain) ->
    return @__resourceInit.getExpressMiddleware(domain)


module.exports = ResourceConditioner
