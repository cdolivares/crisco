Express = require("express")
###
  Application Initializers
###

SchemaInitializer = require("#{__dirname}/schema")
RouteInitializer = require("#{__dirname}/route")

###
  Action and Resource Collectors
###
ActionCollector = require("#{__dirname}/../collectors/action")
ResourceCollector = require("#{__dirname}/../collectors/resource")

###
  Route Conditioners
###
ResourceInitializer =
    require("#{__dirname}/../initializers.resource/resourceinit")
ActionInitializer   =
    require ("#{__dirname}/../initializers.action/actioninit")

###
  Primitive Factory
###
PrimitiveFactory =
    require("#{__dirname}/../primitives/primitivefactory")

###
  Primitive Implementations
###
CriscoModel =
    require("#{__dirname}/../primitives.model/model")
CriscoAction =
    require("#{__dirname}/../primitives.action/action")
CriscoAux =
    require("#{__dirname}/../primitives.aux/aux")

class AppInitializer

  ###
    Method: constructor


  ###
  constructor: (crisco, actions, resources, schemas, plugins, dbSettings) ->

    @__a          = actions
    @__r          = resources
    @__s          = schemas
    @__p          = plugins
    @__dbSettings = dbSettings
    @__c          = crisco

    @__initializers =
      route     : {}

    @__e = Express() 

  init: (clbk) ->

    #Need to first initialize the database so we can inject into
    #our conditioners
    @__initializers.schema   = new SchemaInitializer(@__s, @__p, @__dbSettings)
    @__initializers.schema.init (err) =>
      if err?
        console.error "Problem initializing the database"
        console.error err.message
      else
        @__database = db = @__initializers.schema.database

        ###
          Server configuration needs reference to database.
          Pass in here.
        ###
        if @__c.configuration["server"]?
          @__c.configuration["server"] @__e, db

        primitiveFactory = @_initializePrimitiveFactory()

        @__initializers.resource = resourceInitializer =
            new ResourceInitializer(@__c, db, primitiveFactory)
        @__initializers.action = actionInitializer =
            new ActionInitializer(@__c, db, primitiveFactory)


        resourceCollector = new ResourceCollector(@__c, @__e, resourceInitializer)
        actionCollector = new ActionCollector(@__e, actionInitializer)

        @__initializers.route.resource =
            new RouteInitializer(@__r, resourceCollector)
        @__initializers.route.action   =
            new RouteInitializer(@__a, actionCollector)

        @__initializers.route.resource.init (err) =>
          if err?
            clbk err
          else
            @__initializers.route.action.init (err) =>
              if err?
                clbk err
              else
                console.log "Initializing resources..."
                @__initializers.route.resource.enrich()
                @__initializers.route.action.enrich()
                clbk null, @__e

  ###
    Private Method: _initializePrimitiveFactory
  ###
  _initializePrimitiveFactory: () ->
    #first need to construct the action and route configs
    #This is the first place the configurations are read
    #in.
    domainConfigs =
      resource  : {}
      action    : {}
    
    for n, r of @__r
      domainConfigs.resource[n] = r.serialize()
    for n, a of @__a
      domainConfigs.action[n] = a.serialize()

    primitiveFactory = new PrimitiveFactory(@__c, domainConfigs, @__database)

    primitiveFactory.registerPrimitive "CriscoModel", CriscoModel
    primitiveFactory.registerPrimitive "CriscoAction", CriscoAction
    primitiveFactory.registerPrimitive "CriscoAux", CriscoAux
    return primitiveFactory



    @__g.init()
    #let's also construct serialized configs.
    for n, c of @__g.get()
      @__serializedConfigs[n] = c.serialize()


module.exports = AppInitializer
