class CriscoAction

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
  
    @param - domain - A string representing the
             domain to initalize a new string

    @param - 
  ###
  @init = (domain, req, res) ->
    ###
      Eventually we'll also include logic to initialize
      and cache any shared resources between CriscoModel.
    ###
    routeInfo =
      req: req
      body: req.body
    cm = new @ domain, @__vars.database, routeInfo
    return cm


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

  constructor: (domain, database, routeInfo) ->
    @__domain = domain
    @__database = database
    @__routeInfo = routeInfo
    @__cache = {}

  ###
    Method: log
    
    A configured logger instance for each domain.
    For now defer to default console.log
  ###

  log: () ->
    console.log

  ###
    Method: error

    A configured error instance for each domain.
    For now defer to default console.error
  ###

  error: () ->
    console.error

  ###
    Getters
  ###

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

module.exports = CriscoAction
