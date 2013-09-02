class GameController
  constructor: (@el) ->
    @loadAssets().done =>
      @start()

  loadAssets: ->
    deferred = $.Deferred()
    $.get('/assets/words.json').done (words) =>
      @words = words
      $.get('/assets/sequences.json').done (sequences) =>
        @sequences = sequences
        deferred.resolve()
    deferred

  start: ->
    debugger

  render: ->
    template = require '../templates/game/layout.haml'
    @el.html(template())

  destroy: ->
    console.log 'destroying game'

module.exports = GameController
