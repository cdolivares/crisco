async = require("async")

module.exports = (CriscoModels, Aux, next) ->
  console.log "Running Attachments Middleware"
  job = (type, obj) ->
      return (callback) ->
        obj.attach type, callback
        
  if Aux.response.payload.objs?
    jobs = []
    for a in Aux.attachments by 1
      for o in Aux.response.payload.objs by 1
        jobs.push(job(a,o))
    async.parallel jobs, (err, results) =>
      if not err?
        Aux.response.pack(results, true).send()
  else    
    Aux.response.send()