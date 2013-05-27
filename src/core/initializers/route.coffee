###
  Class: AssetInitializer

  Initializes Action
###

class RouteInitializer

  ###
    Method: constructor

    @param - getter - initializes
    @param - collector - a collector that initializes
             the application with serialized route instances
    @param - conditioner - a request conditioner that knows
             how to transform the raw request express object
             into crisco route primitives
             
  ###
  constructor: (getter, collector) ->
    @__g = getter
    @__c = collector

  init: (clbk) ->
    @__g.init()
    clbk()

  enrich: () ->
    for name, confObj of @__g.get()
      @__c.add name, confObj.serialize()


module.exports = RouteInitializer
