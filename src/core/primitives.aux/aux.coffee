Response = require("#{__dirname}/response")
Info     = require("#{__dirname}/info")

class CriscoAux


  ###

    CLASS METHODS

  ###



  ###
    Private Class Var Container
  ###
  @__vars = {}


  ###
    Static Class Method: Config

    Deals with storing the application level
    configurations.

    @param - appConfigs

    @param - domainConfigs

    @param - database
  ###
  @config = (appConfigs, domainConfigs, database) ->
    @__vars.configs = (@__vars.configs || {})
    @__vars.configs.app = appConfigs
    @__vars.configs.domain = domainConfigs
    @__vars.database = database


  ###
    Static Class Method: Init

    Deals with initializing a new instance of
    CriscoModel.  This understands how to initialize
    off a "req" object from express.
    
    @param - crisco

    @param - domain - A string representing the
             domain to initalize a new Aux object.

    @param - routeInfo
  ###
  @init = (crisco, domain, routeInfo) ->
    ###
      Eventually we'll also include logic to initialize
      and cache any shared resources between CriscoModel.
    ###
    return new @ crisco, domain, @__vars.database, routeInfo

  ###
    
    INSTANCE METHODS

  ###


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
                    route: {
                      Express Object from req.route: see 
                      http://expressjs.com/api.html#req.route for more info
                    } 
                    method: "GET|POST|PUT|DELETE"
                    query:  {queryString: Parameter}
                    body:   {body: Parameter}
             Query and/or body may not be defined
             depending on the HTTP Method used
              
              Example express req.route object:
              { 
                path: '/user/:id?',
                method: 'get',
                callbacks: [ [Function] ],
                keys: [ { name: 'id', optional: true } ],
                regexp: /^\/user(?:\/([^\/]+?))?\/?$/i,
                params: [ id: '12' ] 
              }
  ###

  constructor: (crisco, domain, database, routeInfo) ->
    @__crisco = crisco
    @__domain = domain
    @__database = database
    @__routeInfo = routeInfo
    @__cache = {}

  ###
    Method: log
    
    A configured logger instance for each domain.
    For now defer to default console.log
  ###

  log: (args...) ->
    console.log.apply(null, args)

  ###
    Method: error

    A configured error instance for each domain.
    For now defer to default console.error
  ###

  error: (args...) ->
    console.error.apply(null, args)


  ###
    Getters
  ###

  @::__defineGetter__ "response", () ->
    @__cache.response = @__cache.response || new Response(@__routeInfo)

  @::__defineGetter__ "info", () ->
    @__cache.info = @__cache.info || new Info()


  ###
    req - An untouched Express.js req object.
  ###

  @::__defineGetter__ "req", () ->
    @__routeInfo.req

  ###
    res - An untouched Express.js res object.
  ###

  @::__defineGetter__ "res", () ->
    @__routeInfo.res


  @::__defineGetter__ "routeInfo", () ->
    @__routeInfo

  ###
    Contract is to return an object keyed with
    the query objects.
  ###
  @::__defineGetter__ "query", () ->
    @__routeInfo.req.query

  @::__defineGetter__ "body", () ->
    @__routeInfo.req.body

  @::__defineGetter__ "attachments", () ->
    req = @__routeInfo.req
    if req.query?
      if req.query.attach?
        return req.query.attach.split(',')
    return []

  @::__defineGetter__ "crisco", () ->
    @__crisco

  @::__defineGetter__ "me", () ->
    if not @__routeInfo.req.__crisco?
      return null
    else
      @__routeInfo.req.__crisco.me


module.exports = CriscoAux
