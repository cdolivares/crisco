// Generated by CoffeeScript 1.6.2
(function() {
  var GET,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  GET = (function() {
    /*
        Where a route object is defined as:
        {
          tag: "routeTag"
          route: "/route"
          method: "GET|PUT|POST|DEL"
          handler: RouteFn
        }
    */
    function GET(r) {
      this._default = __bind(this._default, this);
      this.handler = __bind(this.handler, this);      this.__r = r;
    }

    GET.prototype.handler = function(req, res, next) {
      var Aux, CriscoModel,
        _this = this;

      CriscoModel = req.__crisco.model;
      Aux = req.__crisco.aux;
      return this.__r.handler(CriscoModel, Aux, function(runDefault) {
        if (runDefault == null) {
          runDefault = false;
        }
        if (runDefault) {
          console.log("Running default GET handler...");
          return _this._default();
        }
      });
    };

    GET.prototype._default = function() {};

    GET.prototype.__defineGetter__('route', function() {
      return this.__r.route;
    });

    return GET;

  })();

  module.exports = GET;

}).call(this);