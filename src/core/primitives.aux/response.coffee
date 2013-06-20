_ = require("underscore")

class Response

  constructor: (req, res) ->
    @__req = req
    @__res = res
    @__cache = {}
    @__status = 0
    @__message = null

  pack: (objs) ->
    if _.isEmpty objs
      return @
    if _.isArray(objs)
      t = objs[0]._type_ || "payload"
    else
      t = objs._type_ || "payload"
      objs = [objs]
    @__cache.objs = (@__cache.objs || {})
    @__cache.objs["#{t}"] = (@__cache.objs["#{t}"] || []).concat objs
    @

  raw: (obj) ->
    if not _.isArray obj
      obj = [obj]
    @__cache.__raw = (@__cache.__raw || []).concat(obj)
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
      @__res.json @__status, {message: @__messsage}
    else
      payload = @__cache.objs
      if @__cache.__raw?
        if @__cache.objs?
          @__cache.__raw.unshift @__cache.objs
        payload = _.extend.apply _, @__cache.__raw
      @__res.json @__status, {data: payload}

module.exports = Response
