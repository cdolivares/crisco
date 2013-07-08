class Info
  constructor: () ->
    @__info = {}

  set: (property, value) ->
    @__info[property] = value

  get: (property) ->
    @__info[property]

module.exports = Info
