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
  ###
  constructor: (getter, collector) ->
    @_g = getter
    @_c = collector

  init: (clbk) ->
    @_g.init()
    clbk()

  enrich: () ->
    for name, confObj of @_g.get()
      @_c.add name, confObj.serialize()


module.exports = RouteInitializer
