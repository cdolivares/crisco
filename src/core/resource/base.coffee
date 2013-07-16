
###
  This stub initializes the application state...also allows state serialization
  and deserialization so that clients can easily use and inspect the state of
  this action class instance.
###


class BaseResource

  @registerMiddleware = (name, middleware) ->
    @_m = @_m || {}
    @_m[name] = middleware

  @registerDecorator = (name, dec) ->
    @_d = @_d || {}
    @_d[name] = dec

  @clone = (crisco) ->
    f = () ->

    f._routes = []
    f.__vars = {}
    f._d = "default"

    ###
      Before and After hooks
    ###
    f.before = (beforeHooks) ->
      @__vars.bh = beforeHooks

    f.after = (afterHooks) ->
      @__vars.ah = afterHooks

    f.tag = (tag) ->
      @__vars.t = tag

    f.type = (type) ->
      @__vars.type = type

    #let's make f.app simply an application loader that standardizes the 
    #action and route files in a way that CriscoRouter can understand.
    f.app = () ->

    f.domain = (d) ->
      @__vars.d = d


    f.app.get = (route, routeHandler) ->
      ###
        store app routes as obj with
        {
          tag: "SomeTag",
          route: "SomeRoute",
          handler: "SomeHandler",
          getOne: Boolean //whether this route should return a single object or not.
        }
      ###
      f._routes.push
        tag:     f.__vars.t
        type:    f.__vars.type
        route:   f.utils._prefixRoute(route)
        method: "GET"
        handler: routeHandler
        getOne: false
      f._reset()

    f.app.getOne = (route, routeHandler) ->
      ###
        store app routes as obj with
        {
          tag: "SomeTag",
          route: "SomeRoute",
          handler: "SomeHandler",
          getOne: Boolean //whether this route should return a single object or not.
        }
      ###
      f._routes.push
        tag:     f.__vars.t
        route:   f.utils._prefixRoute(route)
        method: "GET"
        handler: routeHandler
        getOne: true
      f._reset()

    f.app.post = (route, routeHandler) ->
      f._routes.push
        tag: f.__vars.t
        type: f.__vars.type
        route: f.utils._prefixRoute(route)
        method: "POST"
        handler: routeHandler
      f._reset()

    f.app.put  = (route, routeHandler) ->
      f._routes.push
        tag: f.__vars.t
        type: f.__vars.type
        route: f.utils._prefixRoute(route)
        method: "PUT"
        handler: routeHandler
      f._reset()

    f.app.del  = (route, routeHandler) ->
      f._routes.push
        tag: f.__vars.t
        route: f.utils._prefixRoute(route)
        method: "DEL"
        handler: routeHandler
      f._reset()

    f._reset = () ->
      f.__vars._t = null
      f.__vars.type = null

    f.utils = {}

    f.utils._prefixRoute = (r) ->
      if crisco.appConfig.routes?
        pre = crisco.appConfig.routes.prefix || ""
      else
        pre = ""
      return "#{pre}#{r}"

    f.serialize = () ->
      #serialization here
      o =
        domain: f.__vars.d || "default"
        beforeHooks: f.__vars.bh
        afterHooks: f.__vars.ah
        routes: f._routes
        m: BaseResource._m

      return o

    f.deserialize = (conf) ->
      @__vars.d = conf.domain || @__vars.d
      @__vars.bh = conf.beforeHooks || @__vars.bh
      @__vars.ah = conf.afterHooks || @__vars.ah
      @_routes = conf.routes || @_routes

    return f

module.exports = BaseResource
