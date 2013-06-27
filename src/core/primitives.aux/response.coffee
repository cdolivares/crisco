_ = require("underscore")

class Response

  constructor: (routeInfo) ->
    @__routeInfo = routeInfo
    @__cache = {}
    @__status = 0
    @__message = null

  #objects registered in pack will be replaced with
  #obj.jsonify()
  pack: (obj, override=false) ->
    if not _.isArray(obj)
      obj = [obj]
    @__cache.objs = (@__cache.objs || [])
    if override
      @__cache.objs = obj
    else
      @__cache.objs = @__cache.objs.concat(obj)
    @

  raw: (obj) ->
    if not _.isArray obj
      obj = [obj]
    @__cache.raw = (@__cache.raw || []).concat(obj)
    @

  success: () ->
    @status(200)
    @

  status: (s) ->
    @__status = s
    @

  message: (m) ->
    @__message = m
    @

  empty: () ->
    @__cache.objs = {}
    @


  send: () ->
    if @__message?
      @__routeInfo.res.json @__status, {message: @__messsage}
    else
      @__cache.payload = []

      #call jsonify() on each object in objs
      if @__cache.objs?
        a = []
        for obj in @__cache.objs by 1
          o = obj.jsonify()
          a.push o
        @__cache.payload = @__cache.payload.concat a

      if @__cache.raw?
        @__cache.payload = @__cache.payload.concat @__cache.raw

      payload = @__cache.payload
      if @_sendOne()
        payload = payload.shift()

      @__routeInfo.res.json @__status, {data: payload}

  #_sendOne is terribly janky. Need to surface more information about the route type
  #from the route configuration to make this more elegant.
  _sendOne: () ->
    return @__routeInfo.getOne or 
          (
            @__routeInfo.method is "POST" and 
            @__routeInfo.route.indexOf("/action") is -1
          ) or
          (@__routeInfo.method is "PUT")

  @::__defineGetter__ 'payload', () ->
    return {
      objs: @__cache.objs,
      raw: @__cache.raw
    }

module.exports = Response
