class POST

  constructor: () ->
    console.log "Initializing default POST"

  handler: () =>

  @::__defineGetter__ 'route', () ->
    "/api/resource/post"

module.exports = POST
