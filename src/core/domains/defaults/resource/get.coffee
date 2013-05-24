class GET

  constructor: () ->
    console.log "Initializing default GET"

  handler: () =>

  @::__defineGetter__ 'route', () ->
    "/api/resource/get"

module.exports = GET
