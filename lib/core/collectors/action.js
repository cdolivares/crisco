// Generated by CoffeeScript 1.6.2
/*
  Class: ActionCollector

  Collects Action level configurations and carries out
  the appropriate operations to add them to an initialized
  express instance.
*/


(function() {
  var ActionCollector, ActionDomain;

  ActionDomain = require("" + __dirname + "/../domains/action");

  ActionCollector = (function() {
    function ActionCollector(crisco, express, actionInitializer) {
      this.__c = crisco;
      this.__e = express;
      this.__a = actionInitializer;
      this.__actions = {};
    }

    /*
      Method: add
      
      Adds an actionDomain to the ActionDomain collection.
      
      @param "string" that's the name of this particular domain
      @param "object" describing the state of the action domain
    */


    ActionCollector.prototype.add = function(name, config) {
      var ad;

      ad = new ActionDomain(this.__c, this.__e, config, this.__a);
      ad.enrich();
      return this.__actions[name] = ad;
    };

    ActionCollector.prototype.get = function(name) {
      if (name != null) {
        return this.__actions[name];
      } else {
        return this.__actions;
      }
    };

    return ActionCollector;

  })();

  module.exports = ActionCollector;

}).call(this);
