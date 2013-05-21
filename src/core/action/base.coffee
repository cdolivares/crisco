
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

    #let's add registered middleware
    if @_m?
      for mName, mDef of @_m
        f[mName] = mDef

    f.app = () ->

    f.domain = (d) ->
      @_d = d

    f.app.action = (route, actionHandler) ->
      console.log "Action !", route

    f._reset = () ->
      @_t = null

    f.serialize = () ->
      #serialization here
      return f._routes

    return f

module.exports = BaseAction
