###
  Class: CriscoModel

  A Crisco primitive that provides
  som database methods to Crisco
  routes and actions.
###

class CriscoModel

  ###
    Method: constructor

    @param - domain <String>, The current
  ###

  constructor: (domain, database, routeInfo) ->
    @__domain = domain
    @__database = database
    @__routeInfo = routeInfo

  populate: (clbk) =>
    console.log "Populating Crisco Model"

  targets: () ->
    console.log "Populating Crisco Targets"

module.exports = CriscoModel
