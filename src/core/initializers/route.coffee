###
  Class: RouteInitializer

  Responsible for reading in
  application configuration
  files. Currently, this means
  Resource and Action definition
  files.
###

class RouteInitializer

  ###
    Method: constructor

    @param - getter - initializes
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

    Initializes the getter which, in turn, requires
    the loaded file or file dir. In this case that means

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
