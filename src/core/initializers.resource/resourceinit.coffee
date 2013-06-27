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

    @param - domain - String
    @param - routeInfo - Object

    routeInfo is constructed for Resources:

      Resources: src/core/resource/base
      Actions: src/core/action/base

    In general this object contains the following properties

      {
        tag:     "String"
        route:   "String"
        method:  "String"
        handler: Function
      }

      If the route is "GET" and a resource then there will be an
      extra parameter set 
      {
        getOne: Boolean
      }
      which specifies whether the client intends this route to respond with a
      singular resource or collection of resources.
  ###
  get: (domain, routeInfo) ->
    return @__resourceInit.getExpressMiddleware(domain, routeInfo)


module.exports = ResourceInitializer
