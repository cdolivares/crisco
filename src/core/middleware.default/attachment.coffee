async = require("async")
_ = require("underscore")

module.exports = (CriscoModels, Aux, next) ->
  console.log "Running Attachments Middleware"
  job = (type, obj) ->
      return (callback) ->
        obj.attach type, Aux.me, callback
  att = Aux.attachments
  if _.isEmpty(Aux.response.payload.objs)
    Aux.response.send()

  else
    jobs = []
    anObject = Aux.response.payload.objs[0]
    for o in Aux.response.payload.objs by 1
      attach = ""
      for a in att by 1 #all user specified attachments
        attach += "," + a
      for k,v of anObject._configuration_.attach #all required attachments
        if k.match(/^required\:/)
          attach += "," + k
      attach = attach.slice(1)
      jobs.push(job(attach, o))
    async.parallel jobs, (err, results) =>
      if not err?
        Aux.response.pack(results, true).send()

defaultJobs = (objectType, callback) ->
  #get
  #check if this configuration has any required attachments
  