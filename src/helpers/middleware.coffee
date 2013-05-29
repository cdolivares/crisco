###
  Helper: Middleware

  Transforms middleware representation from
    {
      "middleware1": 'all'
      "middleware2": {only: "tag1"}
    }

    into an ordered array keyed by the name of each route in the file

    {
      "tag1": ["middleware1", "middleware2"]
      "default": ["middleware1"]
    }

    Middleware formatting options are:


    {
      HookName: "String"
    }

    Where "String" is either
      1. "all"
      2. a comma delimited list of tag names "tag1, tag2, tag3"

    authenticate: "a
###

exports.transform = (m) ->
  keyed = {}
  for n, c of m
    strs = _.map(c.split(','), (el) -> return el.replace(/\s/g, ""))
    if strs[0] is 'all'
      for t, m of keyed #add to each existing tag
        m.push n
      if not keyed['default']?
        keyed['default'] = [n]
    else
      for str in strs
        arr = (keyed[str] || (keyed["default"] || []))
        arr.push n
        keyed[str] = arr

  return keyed
