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

  Crisco.BaseResource = function() {
    return BaseResource.clone();
  }
  Crisco.BaseAction = function() {
    return BaseAction.clone();
  }

  Crisco.BaseSchema = Database.BaseSchema;

  //global utils
  //...but globals are terrible. -chris
  _ = require("underscore");
  _.trim = function(s) {
    s.replace(/\s/g, "");
  }

})(exports);
