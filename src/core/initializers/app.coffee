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
ResourceConditioner =
    require("#{__dirname}/conditioners/resource")
ActionConditioner   =
    require ("#{__dirname}/conditioners/action")


class AppInitializer

  ###
    Method: constructor


  ###
  constructor: (actionsG, resourcesG, schemasG, pluginsG, dbSettingsG) ->
    @__s = schemasG
    @__r = resourcesG
    @__p = pluginsG
    @__a = actionsG
    @__dbSettings = dbSettingsG
    @__initializers = {}
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
        db = @__initializers.schema.database

        resourceConditioner = new ResourceConditioner(db)
        actionConditioner = new ActionConditioner(db)

        resourceCollector = new ResourceCollector(@__e, resourceConditioner)
        actionCollector = new ActionCollector(@__e, resourceConditioner)

        @__initializers.resource =
            new RouteInitializer(@__r, resourceCollector)
        @__initializers.action   =
            new RouteInitializer(@__a, actionCollector)

        @__initializers.resource.init (err) =>
          if err?
            clbk err
          else
            @__initializers.action.init (err) =>
              if err?
                clbk err
              else
                console.log "Initializing resources..."
                @__initializers.resource.enrich()
                # @__initializers.action.enrich()
                clbk null, @__e


module.exports = AppInitializer
