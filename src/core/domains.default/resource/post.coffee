class POST

  constructor: (crisco, r) ->
    console.log "Initializing default POST"

  handler: () =>

  @::__defineGetter__ 'route', () ->
    "/api/resource/post"

module.exports = POST
