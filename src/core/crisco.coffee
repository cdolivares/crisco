
BaseAction   = require("#{__dirname}/action/base")
BaseResource = require("#{__dirname}/resource/base")
Getter       = require("#{__dirname}/../helpers/getter")
_            = require("underscore")
ApplicationInitializer =
    require("#{__dirname}/initializers/app")

BaseSchema =
    require("database").BaseSchema

###
  Default Middleware
###
PermissionMiddleware =
    require("#{__dirname}/middleware.default/permission")
AuthenticationMiddleware =
    require("#{__dirname}/middleware.default/authentication")
AttachmentMiddleware =
    require("#{__dirname}/middleware.default/attachment")

###
  Make default Database Permission object available
###
Permission = require("database").Permission

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

    @__config = config

    _.defaults @__config, 
      schemas   : {}
      plugins   : {}
      actions   : {}
      resources : {}


    @__customMiddleware = {}
    @__configCallbacks = {}


  ###
    Method: registerMiddleware

    Allows clients to registers middleware for use in action and route
    definitions.  For now each middleware module is registered for both
    actions and resources.
  ###

  registerMiddleware: (name, middleware) ->
    @__customMiddleware[name] = middleware
    #register with Action and Resources
    BaseAction.register name, middleware
    BaseResource.register name, middleware

  ###
  ###

  options: (config) ->
    if not arguments.length
      return @__config 

    @__config = config

  ###
    Method: configure

    A configure hook that allows the client to configure
    different parts of the application initialization
    process.

    For now, the only configuration type is "server"
  ###
  configure: (type, clbk) ->
    @__configCallbacks[type] = clbk

  getMiddleware: (name) ->
    @__customMiddleware[name]


  ###
    Method: use

    uses a plugin 
  ###

  use: (options = {}) ->

    if @__initialized
      throw new Error "cannot use a plugin after initialization"

    for moduleType in Object.keys(@__config)
      if modules = options[moduleType]
        _.extend @__config[moduleType], modules



  ### 
  ###

  start: (clbk = () ->) ->
    @__initialized = true

    config           = @__config

    ###
      Register Default Middleware
        -Authentication
        -Permissions
    ###

    @registerMiddleware "verifyPermissions", PermissionMiddleware
    @registerMiddleware "authenticate", AuthenticationMiddleware
    @registerMiddleware "addAttachments", AttachmentMiddleware

    # #Initialization a bit verbose here...let's cleanup
    app = new ApplicationInitializer(
              @,
              config.actions,
              config.resources,
              config.schemas,
              config.plugins,
              config.dbSettings
              )

    app.init (err, express) =>
      clbk err, express


  ###
    Convenience Getters
  ###
  @::__defineGetter__ 'BaseAction', () ->
    return BaseAction.clone @

  @::__defineGetter__ 'BaseResource', () ->
    return BaseResource.clone @

  @::__defineGetter__ 'BaseSchema', () ->
    return BaseSchema

  @::__defineGetter__ 'appConfig', () ->
    return @__config

  @::__defineGetter__ 'configuration', () ->
    return @__configCallbacks

  @::__defineGetter__ "Permission", () ->
    Permission


module.exports = Crisco
