$ = require 'jqueryify'

class Assets
  load: ->
    deferred = $.Deferred()
    promise = $.get(@url)
    promise.done (contents) =>
      @list = contents
      deferred.resolve(@)
    deferred

class Words extends Assets
  url: '/assets/words.json'

class Sequences extends Assets
  url: '/assets/sequences.json'


module.exports =
  words: Words
  sequences: Sequences
