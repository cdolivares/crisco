CriscoResourceInit =
    require("#{__dirname}/../middleware.resource/init")


###
  Class: ResourceInitializer

  Initializes a set of express compliant middleware that
  takes the raw request object and creates the Crisco
  route primitives CriscoModels and Aux

  @param - database - An instance of database
  @param - primitiveFactory - An instance of primitiveFactory
           that can initialize application primitives such
           as CriscoModel, CriscoAction, and Aux
###

class ResourceInitializer

  constructor: (crisco, database, primitiveFactory) ->
    @__c  = crisco
    @__db = database
    @__resourceInit = new CriscoResourceInit(@__c, @__db, primitiveFactory)
    @__resourceInit.init()


  ###
    Method: get

    Returns an array of express middleware
    compliant functions that create
    our crisco resource primitives
  ###
  get: (domain) ->
    return @__resourceInit.getExpressMiddleware(domain)


module.exports = ResourceInitializer
