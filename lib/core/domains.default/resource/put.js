// Generated by CoffeeScript 1.6.2
(function() {
  var PUT,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  PUT = (function() {
    function PUT() {
      this.handler = __bind(this.handler, this);      console.log("Initializing default PUT");
    }

    PUT.prototype.handler = function() {};

    PUT.prototype.__defineGetter__('route', function() {
      return "/api/resource/put";
    });

    return PUT;

  })();

  module.exports = PUT;

}).call(this);