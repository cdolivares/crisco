###
  Class: RouteInitializer

  The RouteInitializer acts as a bridge between
  the actual crisco domain objects and serializing
  those objects in a way a configurer can understand.

  The chain fits like this

  (Crisco Resource/Action Definitions) ---> RouteInitializer ---> Collector ---> Domain Implementer

  Along each of the steps the transformation loo

  1. RouteInitializer serializes the Raw Resource definitions into a standard format.

  2. The Collector is responsible for injecting an instance
     of our server (currently is Express.js), and a domain configuration to
     the Domain Implementer

  3. The Domain Implementer does all the heavy lifting of registering all
     the different pieces to our server.

      a) Middleware to initialize the Crisco Primitive
      b) Injecting the appropriate before hooks into each route
      c) Registering a default handler to which the client can
         optionally defer.

  The different components of this chain can be found here

    -Crisco Resource Defn: Specified by the client in crisco.__config.actions
    -Crisco Action Defn: Specified by the client in crisco.__config.resources
    -RouteInitializer: This file :)
    -Collector: src/core/collectors/*
    -Domain Implementer: src/core/domains/*
###

class RouteInitializer

  ###
    Method: constructor

    @param - resources - initializes
    @param - collector - a request collector that knows
             how to add serialized configuration objects
             to the target server, in this case Express.
             
  ###
  constructor: (resources, collector) ->
    @__r = resources
    @__c = collector
    @__serializedConfigs = {}


  ###
    Method: init

  ###

  init: (clbk) ->
    #let's also construct serialized configs.
    for n, c of @__r
      @__serializedConfigs[n] = c.serialize()
    clbk()

  enrich: (clbk) ->
    for name, confObj of @__r
      @__c.add name, confObj.serialize()

  ###
    Getter Configs
  ###

  @::__defineGetter__ "serializedConfigs", () ->
    @__serializedConfigs

module.exports = RouteInitializer
