class DEL

  constructor: (crisco, r) ->
    console.log "Initializing default DEL"

  handler: () =>

  @::__defineGetter__ 'route', () ->
    "/api/resource/del"

module.exports = DEL
