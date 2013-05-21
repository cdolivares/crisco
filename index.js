(function (exports) {
  var Crisco,
      BaseResource,
      CriscoCore,
      BaseAction;


  CriscoCore = require("./lib/core/crisco")

  exports = Crisco = function(config) {
    //initialize Crisco here.
    crisco = new CriscoCore(config);
    return crisco;
  }

  BaseResource = require("./lib/core/resource/base");
  BaseAction   = require("./lib/core/actions/base");

  Crisco.BaseResource = function() {
    return BaseResource.clone();
  }
  Crisco.BaseAction = function() {
    return BaseAction.clone();
  }

  //global utils
  //...but globals are terrible. -chris
  _ = require("underscore")

})(exports);
