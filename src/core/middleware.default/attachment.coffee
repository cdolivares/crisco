async = require("async")
_ = require("underscore")

module.exports = (CriscoModels, Aux, next) ->
  console.log "Running Attachments Middleware"
  job = (type, obj) ->
      return (callback) ->
        obj.attach type, Aux.me, callback
  att = Aux.attachments 
  if Aux.response.payload.objs? and not _.isEmpty(att)
    jobs = []
    for a in att by 1
      for o in Aux.response.payload.objs by 1
        jobs.push(job(a,o))
    async.parallel jobs, (err, results) =>
      if not err?
        Aux.response.pack(results, true).send()
  else    
    Aux.response.send()