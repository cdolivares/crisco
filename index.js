(function (exports) {
  var Crisco, BaseResource, BaseAction;

  exports = Crisco = function() {
    //initialize Crisco here.
  }

  BaseResource = require("./lib/core/baseresource");
  BaseAction   = require("./lib/core/baseaction");

  Crisco.BaseResource = function() {
    return BaseResource.clone();
  }
  Crisco.BaseAction = function() {
    return BaseAction.clone();
  }

})(exports);
