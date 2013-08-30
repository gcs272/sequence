class GameController
  constructor: (@el) ->

  render: ->
    template = require '../templates/game/layout.haml'
    @el.html(template())
    console.log 'rendering game'

  destroy: ->
    console.log 'destroying game'

module.exports = GameController
