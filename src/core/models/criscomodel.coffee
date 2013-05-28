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
    @param - database <Object>, and instance
             of the dojo database object.
    @param - routeInfo - an object containing
             information about this specific
             request
             Includes:
                  routeInfo =
                    route:  "/a/route"
                    method: "GET|POST|PUT|DELETE"
                    query:  {queryString: Parameter}
                    body:   {body: Parameter}
             Query and/or body may not be defined
             depending on the HTTP Method used
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
