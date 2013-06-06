class PUT

  constructor: () ->
    console.log "Initializing default PUT"

  handler: () =>

  @::__defineGetter__ 'route', () ->
    "/api/resource/put"

module.exports = PUT
