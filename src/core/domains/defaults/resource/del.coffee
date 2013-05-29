class DEL

  constructor: () ->
    console.log "Initializing default DEL"

  handler: () =>

  @::__defineGetter__ 'route', () ->
    "/api/resource/del"

module.exports = DEL
