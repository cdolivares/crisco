###
  Class: Getter

  Small module that either requires a file or reads
  from a directory of files
###

fs = require('fs')

class Getter
  
  constructor: (@_p) ->

  #proxy method for ensuring the files have been read in...
  init: () ->
    @_load()

  get: () ->
    return @_elems || @_elems = @_load()

  @::__defineGetter__ 'path', () ->
    return @_p

  _prefix: (fileName) ->
    return fileName.split(".")[0]

  _load: () ->
    #either require or fs read
    if fs.statSync(@_p).isFile()
      elems = require(@_p)
    else
      elems = {}
      files = fs.readdirSync(@_p)
      for file in files
        if fs.statSync("#{@_p}/#{file}").isFile()
          elems[@_prefix(file)] = require("#{@_p}/#{file}")
    return elems

module.exports = Getter
