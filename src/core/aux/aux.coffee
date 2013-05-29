###
  Class: Aux

  Aux takes a resource configuration and exposes
###

class Aux

  constructor: (domain, logger) ->
    @__domain = domain
    @__logger = logger

  ###
    Method: log

    Proxies the log message to the application
    logger.
  ###
  log: () ->

  ###
    Method: error

    Proxies the error message to the application
    error logger.
  ###
  error: () ->

  ###
    Method: set

    Used to set variables on this instance, but
    should really only be used to set express
    req and res instances.
  ###

  set: (name, v) ->
    this["__#{name}"] = v

  @::__defineGetter__ 'req', () ->
    @__req

  @::__defineGetter__ 'res', () ->
    @__res

module.exports = Aux
