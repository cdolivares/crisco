class ActionInitializer

  constructor: (actionGetter) ->
    @_actionGetter = actionGetter

  init: (clbk) ->
    @_actionGetter.init()
    clbk null

  ###
    Method: enrich

    Takes an express instance and enriches the
    server with the appropriate models.
  ###
  enrich: (express, clbk) ->
    ActionConfigurations = @_actionGetter.get()


module.exports = ActionInitializer
