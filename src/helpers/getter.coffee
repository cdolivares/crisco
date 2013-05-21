###
  Class: Getter

  Small module that either requires a file or reads
###

fs = require('fs')

class Getter
  
  constructor: (@_p) ->

  load: (clbk) ->
    #either require or fs read
    fs.stat @_p, (err, stats) =>
      if err?
        clbk err
      else
        if stats.isFile()
          @_elems = require(@_p)
        else
          @_elems = {}
          files = fs.readdirSync(@_p)
          for file in files
            @_elems[file] = require("#{__dirname}/file")
          clbk null


  get: () ->
    return @_elems

  @::__defineGetter__ 'path', () ->
    return @_p

module.exports = Getter
