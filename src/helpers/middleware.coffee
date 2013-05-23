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

    Middleware formatting options will be detailed in
###

exports.transform = (m) ->
  for n, c of m
    
    return {}