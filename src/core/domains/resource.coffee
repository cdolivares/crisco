
###
  Default Resourceful Implementations
###

DefaultGet  =
    require("#{__dirname}/defaults/resource/get")
DefaultPut  =
    require("#{__dirname}/default/resource/put")
DefaultPost =
    require("#{__dirname}/default/resource/post")
DefaultDel  =
    require("#{__dirname}/default/resource/del")

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

  constructor: (express, config) ->
    @__e = express
    @__c = config

  enrich: () ->
    routeKeyedBefore = MWareTransformer.transform @__c.beforeHooks
    routeKeyedAfter  = MWareTransformer.transform @__c.afterHooks

    for r in @__c.routes
      beforeHooks = routeKeyedBefore[r.tag] || routeKeyedBefore["default"]
      afterHooks = routeKeyedAfter[r.tag] || routeKeyedAfter["default"]
      [fn, routeHandler] = @_constructRouteHandler(r)
      args = [routeHandler.route]
                .concat(beforeHooks)
                .concat([routeHandler.handler])
                .concat(afterHooks)
      fn.apply(fn, args)


  _constructRouteHandler: (r) ->

    switch r.method
      when "GET"
        fn = @__e.get
        #construct handler
        d = new DefaultGet()
      when "POST"
        fn = @__e.post
        d = new DefaultPost()
      when "PUT"
        fn = @__e.put
        d = new DefaultPut()
      when "DEL"
        fn = @__e.delete
        d = new DefaultDel()
      else
        console.error "Invalid HTTP Route #{routeDef.method} for #{routeDef.route}"
        return []
    return [fn, d]

module.exports = ResourceDomain
