// Generated by CoffeeScript 1.6.2
(function() {
  var async, _;

  async = require("async");

  _ = require("underscore");

  module.exports = function(CriscoModels, Aux, next) {
    var a, att, job, jobs, o, _i, _j, _len, _len1, _ref,
      _this = this;

    console.log("Running Attachments Middleware");
    job = function(type, obj) {
      return function(callback) {
        return obj.attach(type, callback);
      };
    };
    att = Aux.attachments;
    if ((Aux.response.payload.objs != null) && !_.isEmpty(att)) {
      jobs = [];
      for (_i = 0, _len = att.length; _i < _len; _i += 1) {
        a = att[_i];
        _ref = Aux.response.payload.objs;
        for (_j = 0, _len1 = _ref.length; _j < _len1; _j += 1) {
          o = _ref[_j];
          jobs.push(job(a, o));
        }
      }
      return async.parallel(jobs, function(err, results) {
        if (err == null) {
          return Aux.response.pack(results, true).send();
        }
      });
    } else {
      return Aux.response.send();
    }
  };

}).call(this);