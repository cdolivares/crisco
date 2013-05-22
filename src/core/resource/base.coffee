
###
  This stub initializes the application state...also allows state serialization
  and deserialization so that clients can easily use and inspect the state of
  this action class instance.
###


class BaseResource

  @register = (name, middleware) ->
    @_m = @_m || {}
    @_m[name] = middleware

  @clone = () ->
    f = () ->

    f._routes = []
    f._d = "default"

    ###
      Before and After hooks
    ###
    f.before = (beforeHooks) ->
      @_bh = beforeHooks

    f.after = (afterHooks) ->
      @_ah = afterHooks

    #let's add registered middleware
    # if @_m?
    #   for mName, mDef of @_m
    #     f[mName] = mDef


    f.tag = (tag) ->
      @_t = tag

    #let's make f.app simply an application loader that standardizes the 
    #action and route files in a way that CriscoRouter can understand.
    f.app = () ->

    f.domain = (d) ->
      @_d = d


    f.app.get = (route, routeHandler) ->
      ###
        store app routes as tuples with
        {
          tag: "SomeTag",
          route: "SomeRoute",
          handler: "SomeHandler"
        }
      ###
      f._routes.push
        tag:     @_t
        route:   route
        handler: routeHandler
      f._reset()

    f.app.post = (route, routeHandler) ->
      f._routes.push
        tag: @_t
        route: route
        handler: routeHandler
      f._reset()

    f.app.put  = (route, routeHandler) ->
      f._routes.push
        tag: @_t
        route: route
        handler: routeHandler
      f._reset()

    f.app.del  = (route, routeHandler) ->
      f._routes.push
        tag: @_t
        route: route
        handler: routeHandler
      f._reset()

    f._reset = () ->
      @_t = null

    f.serialize = () ->
      #serialization here
      o =
        domain: f._d
        beforeHooks: f._bh
        afterHooks: f._ah
        routes: f._routes
      return o

    f.deserialize = (conf) ->
      @_d = conf.domain || @_d
      @_bh = conf.beforeHooks || @_bh
      @_ah = conf.afterHooks || @_ah
      @_routes = conf.routes || @_routes

    return f

module.exports = BaseResource
