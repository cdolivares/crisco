###
  Class: ResourceCollector

  Collects Resource level configurations and carries out
  the appropriate operations to add them to an initialized
  express instance.

###
ResourceDomain = require("#{__dirname}/../domains/resource")


class ResourceCollector

  constructor: (crisco, express, resourceInitializer) ->
    @__c = crisco
    @__e = express
    @__r = resourceInitializer
    @__resources = {}

  ###
    Method: add
    
    Adds a resourceDomain to the ResourceDomain collection. This
    also initializes the server instance with this resource
    domain
    
    @param "string" that's the name of this particular domain
    @param "object" describing the state of the resource domain
  ###

  add: (name, config) ->
    #inject domain handlers with the conditioner.
    rd = new ResourceDomain(@__c, @__e, config, @__r)
    rd.enrich()
    @__resources[name] = rd

  get: (name) ->
    if name?
      return @__resources[name]
    else
      return @__resources

module.exports = ResourceCollector
