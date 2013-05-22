###
  Class: Getter

  Small module that either requires a file or reads
###

fs = require('fs')

class Getter
  
  constructor: (@_p) ->

  load: () ->
    #either require or fs read
    if fs.statSync(@_p).isFile()
      @_elems = require(@_p)
    else
      @_elems = {}
      files = fs.readdirSync(@_p)
      for file in files
        if fs.statSync("#{@_p}/#{file}").isFile()
          @_elems[@_prefix(file)] = require("#{@_p}/#{file}")
    return @

  get: () ->
    return @_elems

  @::__defineGetter__ 'path', () ->
    return @_p

  _prefix: (fileName) ->
    return fileName.split(".")[0]

module.exports = Getter
