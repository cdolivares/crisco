
###
  Default Resourceful Implementations
###


routeHandlers = 
  "GET": 
    method: "get"
    klass: require("#{__dirname}/../domains.default/resource/get")

  "PUT": 
    method: "put"
    klass: require("#{__dirname}/../domains.default/resource/put")

  "POST" : 
    method: "post"
    klass: require("#{__dirname}/../domains.default/resource/post")

  "DEL"  : 
    method: "delete"
    klass: require("#{__dirname}/../domains.default/resource/del")

###
  Crisco Middleware Wrapper
###
MiddlewareWrapper =
    require("#{__dirname}/../middleware/criscowrapper")

###
  Helpers
###
MWareTransformer =
    require("#{__dirname}/../../helpers/middleware")

###
  Class: ResourceDomain

  Responsible for configuring an express
  server instance with a single resource
  domain.
###


class ResourceDomain

  ###
    Method: constructor

    @param - express - instance of express
    @param - config - An object describing a 
             resource domain.
             See resource/base for more information.
    @param - resourceInitializer - A Getter class
             that returns an array of express compliant
             middleware that initializes our Crisco
             primitives.
      {
        domain: "resourceDomain Name",
        beforeHooks: {"hookName": "opts"},
        afterHooks: {"hookName": "opts"},
        routes: <a route object>,
        m: {"mName": mObject}
      }

      Where a route object is defined as:
      {
        tag: "routeTag"
        route: "/route"
        method: "GET|PUT|POST|DEL"
        handler: RouteFn
      }
  ###

  constructor: (express, config, resourceInitializer) ->
    @__e = express
    @__c = config
    @__rInit = resourceInitializer

  enrich: () ->
    routeKeyedBefore = MWareTransformer.transform @__c.beforeHooks
    routeKeyedAfter  = MWareTransformer.transform @__c.afterHooks
    for r in @__c.routes
      beforeHooks = routeKeyedBefore[r.tag] || routeKeyedBefore["default"]
      afterHooks = routeKeyedAfter[r.tag] || routeKeyedAfter["default"]
      [fn, routeHandler] = @_constructRouteHandler(r)
      clbk = (req, res, next) ->
      # Need to start the crisco chain with a Crisco route conditioner
      beforeHooks = _.filter(_.map(beforeHooks, (n) => @__c.m[n]), (z) => _.isFunction(z))
      afterHooks = _.filter(_.map(afterHooks, (n) => @__c.m[n]), (z) => _.isFunction(z))
      wrappedBeforeHooks = _.map(beforeHooks,
          (bh) => 
            z = new MiddlewareWrapper(bh)
            return z.handler()
          )
      wrappedAfterHooks = _.map(afterHooks,
          (ah) =>
            z = new MiddlewareWrapper(ah)
            return z.handler()
          )
      args =  [routeHandler.route] 
                .concat(@__rInit.get(@__c.domain))
                .concat(wrappedBeforeHooks) #map to middleware defns and filter out undefined values
                .concat([routeHandler.handler])
                .concat(wrappedAfterHooks)
                .concat([clbk])
      fn.apply(@__e, args)


  _constructRouteHandler: (r) ->

    routeInfo = routeHandlers[r.method]

    unless routeInfo
      console.error "Invalid HTTP Route #{routeDef.method} for #{routeDef.route}"
      return []

    return [@__e[routeInfo.method], new routeInfo.klass(@__c, r)]


module.exports = ResourceDomain
