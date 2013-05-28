// Generated by CoffeeScript 1.4.0

/*
  Class: CriscoModel

  A Crisco primitive that provides
  som database methods to Crisco
  routes and actions.
*/


(function() {
  var CriscoModel,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  CriscoModel = (function() {
    /*
        Method: constructor
    
        @param - domain <String>, The current
        @param - database <Object>, and instance
                 of the dojo database object.
        @param - routeInfo - an object containing
                 information about this specific
                 request
                 Includes:
                      routeInfo =
                        route:  "/a/route"
                        method: "GET|POST|PUT|DELETE"
                        query:  {queryString: Parameter}
                        body:   {body: Parameter}
                 Query and/or body may not be defined
                 depending on the HTTP Method used
    */

    function CriscoModel(domain, database, routeInfo) {
      this.populate = __bind(this.populate, this);
      this.__domain = domain;
      this.__database = database;
      this.__routeInfo = routeInfo;
    }

    CriscoModel.prototype.populate = function(clbk) {
      return console.log("Populating Crisco Model");
    };

    CriscoModel.prototype.targets = function() {
      return console.log("Populating Crisco Targets");
    };

    return CriscoModel;

  })();

  module.exports = CriscoModel;

}).call(this);