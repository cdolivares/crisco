###
  Class: CriscoModel

  Provides resource routes with some
  model population convenience methods,
  access to the database layers.
###


class CriscoModel

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
  @init = (domain, req) ->
    ###
      Eventually we'll also include logic to initialize
      and cache any shared resources between CriscoModel.
    ###
    routeInfo =
      route:  _.extend(req.route, {url: req.url})
      method: req.method
      query:  req.query
      body:   req.body
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
    Method: populate

    Populates a set of models based on model information
    sent from the client via HTTP.

    GETs are expected to follow restful conventions
    Eg.
      /collection1/:collection1_id/collection2/:collection2_id
      
      will return an object with the results
        {
          collection1: <MongooseModel>,
          collection2: <MongooseModel>
        }

      if the model can't be found then the collection will be
      undefined in the object.

    @param - name <String> - Optional. If passed in then
             only that collection will be populated. Can
             also be a comma-delimited list of collections
             eg. teachers,students,classes
    @param - clbk <Function> - (err, populatedObject)

  ###
  populate: (name, clbk) =>
    if _.isFunction name
      targets = @targets()
      clbk = name
    else
      targets = _.intersection(name.split(','), @targets()) #trim split name?


    fnd = (primaryName, secondaryName) =>
      return (callback) =>
        drivers = @__database.drivers
        drivers[primaryName].findById @getParam(secondaryName), (err, obj) =>
          if err?
            callback err, null
          else if obj?
            callback null, obj
          else
            callback null, null

    nodeManager = @__database.nodeManager
    finds = {}
    for target in targets
      #get primary db name from nodeManager
      node = nodeManager.find target
      if node?
        name = node.name
        finds["#{target}"] = fnd(node.name, target)

    myAsync.parallel finds, (err, results) =>
      if results?  #done
        clbk null, results


  ###
    Method: targets

  ###


  targets: () ->
    _.reject(  #simplify and make more robust.
        _.reject(
            @__routeInfo.route.path.split('/'),
            (r) ->
              return (r.indexOf(":") isnt -1)
        ), 
        (r2) ->
          ((r2.length < 1) or (r2 is 'api'))
    ).reverse()

  ###
    Method: getParam

  ###

  getParam: (name) ->
    regexp = "\/#{name}\/([^\/\?]+)"
    @__routeInfo.route.url.match(regexp)[1]

  @::__defineGetter__ "database", () ->
    return @__database

module.exports = CriscoModel
