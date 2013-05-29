
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

    f.app.action = (route, actionHandler) ->
      console.log "Action !", route

    f._reset = () ->
      @__vars.t = null

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
