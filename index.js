(function (exports) {
  var Crisco,
      BaseResource,
      CriscoCore,
      BaseAction,
      Database;

  CriscoCore = require("./lib/core/crisco");
  Database = require("database");

  exports.Crisco = Crisco = function(config) {
    //initialize Crisco here.
    crisco = new CriscoCore(config);
    return crisco;
  }

  BaseResource = require("./lib/core/resource/base");
  BaseAction   = require("./lib/core/action/base");

  exports.BaseResource = function() {
    return BaseResource.clone();
  }
  exports.BaseAction = function() {
    return BaseAction.clone();
  }

  exports.BaseSchema = Database.BaseSchema;
  exports.Permission = Database.Permission;

  //global utils
  //...but globals are terrible. -chris
  _ = require("underscore");
  _.trim = function(s) {
    s.replace(/\s/g, "");
  }

})(exports);
