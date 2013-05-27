###
  Class: ResourceCollector

  Collects Resource level configurations and carries out
  the appropriate operations to add them to an initialized
  express instance.

###
ResourceDomain = require("#{__dirname}/../domains/resource")


class ResourceCollector

  constructor: (express, conditioner) ->
    @__e = express
    @__cond = conditioner
    @__resources = {}

  ###
    Method: add
    
    Adds a resourceDomain to the ResourceDomain collection.
    
    @param "string" that's the name of this particular domain
    @param "object" describing the state of the resource domain
  ###

  add: (name, config) ->
    #inject domain handlers with the conditioner.
    rd = new ResourceDomain(@__e, config, @__cond)
    rd.enrich()
    @__resources[name] = rd

  get: (name) ->
    if name?
      return @__resources[name]
    else
      return @__resources

module.exports = ResourceCollector
