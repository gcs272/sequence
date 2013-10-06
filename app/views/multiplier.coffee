class MultiplierView
  constructor: (@el) ->

  render: (multiplier) ->
    template = require '../templates/game/multiplier.haml'

    mx = Math.round(multiplier * 10) / 10
    @el.html template
      multiplier: mx.toFixed(1)

module.exports = MultiplierView
