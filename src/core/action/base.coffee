
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
    f._d = 'default'

    ###
      Before and After hooks
    ###
    f.before = (beforeHooks) ->
      @_bh = beforeHooks

    f.after = (afterHooks) ->
      @_ah = afterHooks

    f.app = () ->

    f.domain = (d) ->
      @_d = d

    f.app.action = (route, actionHandler) ->
      console.log "Action !", route

    f._reset = () ->
      @_t = null

    f.serialize = () ->
      #serialization here
      o =
        domain: f._d
        beforeHooks: f._bh
        afterHooks: f._ah
        routes: f._routes
        m: BaseAction._m

      return o

    f.deserialize = (conf) ->
      @_d = conf.domain || @_d
      @_bh = conf.beforeHooks || @_bh
      @_ah = conf.afterHooks || @_ah
      @_routes = conf.routes || @_routes

    return f

module.exports = BaseAction
