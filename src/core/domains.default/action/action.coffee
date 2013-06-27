class DefaultAction
  ###
      Where a route object is defined as:
      {
        tag: "routeTag"
        route: "/route"
        method: "GET|PUT|POST|DEL"
        handler: RouteFn
      }
  ###
  constructor: (r) ->
    @__r = r

  handler: (req, res, next) =>
    CriscoAction = req.__crisco.action
    Aux = req.__crisco.aux
    @__r.handler CriscoAction, Aux, (runDefault=false) =>
      #require users to call this function and pass in some
      #optional flag for
      if runDefault
        console.log "There is no default action implementation. Skipping..."
      else
        next()

  @::__defineGetter__ 'route', () ->
    @__r.route

module.exports = DefaultAction
