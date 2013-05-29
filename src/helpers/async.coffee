###
	Async.js does not seem to work as expected in some
	cases. Writing some quick helpers here
###

exports.parallel = (obj, appClbk) ->
  ctr = 0

  clbk = (length, results, key, add, err, result) ->
    if err?
      appClbk err, null
    else if result?
      if key?
        add(key, result)
      else
        add(result)
    if ctr++ is length - 1
      appClbk null, results

  if _.isObject(obj)
    len = Object.keys(obj).length
    results = {}
    add = (k,v) ->
      results[k] = v
    for key,fn of obj
      fn clbk.bind(@, len, results, key, add)
  else if _.isArray(obj)
    results = []
    add = (o) ->
      results.push o
    for a in obj
      fn clbk.bind(@, obj.len, results, null, add)
  else
    console.error "Unsupported async arg."
