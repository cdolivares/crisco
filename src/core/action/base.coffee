
###
  This stub initializes the application state...also allows state serialization
  and deserialization so that clients can easily use and inspect the state of
  this action class instance.
###


class BaseAction

  @register = (name, middleware) ->
    @_m = @_m || {}
    @_m[name] = middleware

  @clone = () ->
    f = () ->

    f._routes = []
    f.__vars = {}
    f._d = 'default'

    ###
      Before and After hooks
    ###
    f.before = (beforeHooks) ->
      @__vars.bh = beforeHooks

    f.after = (afterHooks) ->
      @__vars.ah = afterHooks

    f.app = () ->

    f.domain = (d) ->
      @_d = d

    f.app.post = (route, actionHandler) ->
      console.log "BASE! ", f.utils._prefixRoute(route)
      f._routes.push
        tag: f.__vars.t
        route: f.utils._prefixRoute(route)
        method: "POST"
        handler: actionHandler
      f._reset()

    f._reset = () ->
      @__vars.t = null

    f.utils = {}

    f.utils._prefixRoute = (r) ->
      if Crisco.appConfig.routes?
        pre = Crisco.appConfig.routes.prefix || ""
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
        m: BaseAction._m

      return o

    f.deserialize = (conf) ->
      @__vars.d = conf.domain || @__vars.d
      @__vars.bh = conf.beforeHooks || @__vars.bh
      @__vars.ah = conf.afterHooks || @__vars.ah
      @_routes = conf.routes || @_routes

    return f

module.exports = BaseAction
