###
  Class: ResourceCollector  aka. "Factory"

  Collects Resource level configurations and carries out
  the appropriate operations to add them to an initialized
  express instance.

###
ResourceDomain = require("#{__dirname}/../domains/resource")


class ResourceCollector

  constructor: (express) ->
    @_e = express
    @_resources = {}

  ###
    Method: add
    
    Adds a resourceDomain to the ResourceDomain collection.
    
    @param "string" that's the name of this particular domain
    @param "object" describing the state of the resource domain
  ###

  add: (name, config) ->
    rd = new ResourceDomain(@_e, config)
    rd.enrich()
    @_resources[name] = rd

  get: (name) ->
    if name?
      return @_resources[name]
    else
      return @_resources

module.exports = ResourceCollector
