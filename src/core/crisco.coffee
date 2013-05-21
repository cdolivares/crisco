BaseAction   = require("#{__dirname}/action/base")
BaseResource = require("#{__dirname}/resource/base")
Getter       = require("#{__dirname}/../helpers/getter")
ApplicationInitializer =
    require("#{__dirname}/initializers/app")

###
  Class: Crisco

  Application class that exports application level functions.

  Also exposes enriched BaseAction and BaseResource classes.
###
class Crisco

  ###
    Method: constructor


  ###

  constructor: (config) ->
    @_config = config
    @_customMiddleware = {}

    #let's export crisco into the Global Namespace for
    #visibility in Resource and Action Controllers
    global.Crisco = @


  ###
    Method: registerMiddleware

    Allows clients to registers middleware for use in action and route
    definitions.  For now each middleware module is registered for both
    actions and resources.
  ###

  registerMiddleware: (name, middleware) ->
    @_customMiddleware[name] = middleware
    #register with Action and Resources
    BaseAction.register name, middleware
    BaseResource.register name, middleware

  start: (clbk) ->
    config           = @_config
    schemasGetter    = new Getter(config.schemaPath)
    resourceGetter   = new Getter(config.resourcePath)
    pluginGetter     = new Getter(config.pluginPath)
    dbSettingsGetter = new Getter(config.dbSettingsPath)
    actionsGetter    = new Getter(config.actionsPath)

    #Initialization a bit verbose here...let's cleanup
    app = new ApplicationInitializer(
              schemasGetter,
              resourceGetter,
              pluginGetter,
              dbSettingsGetter,
              actionsGetter
              )

    app.init (err) =>
      console.log "App Initialized"
      

  ###
    BaseAction and BaseResource Getters
  ###
  @::__defineGetter__ 'BaseAction', () ->
    return BaseAction

  @::__defineGetter__ 'BaseResource', () ->
    return BaseResource


module.exports = Crisco
