Words = require('../models/assets.coffee').words
Sequences = require('../models/assets.coffee').sequences

class GameController
  constructor: (@el) ->
    @initialize()
 
  initialize: ->
    new Words().load().done (words) =>
      @words = words.list
      new Sequences().load().done (sequences) =>
        @sequences = sequences.list
        @start()

  start: ->
    debugger

  render: ->
    template = require '../templates/game/layout.haml'
    @el.html(template())

  destroy: ->
    console.log 'destroying game'

module.exports = GameController
