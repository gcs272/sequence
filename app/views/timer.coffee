class TimerView
  constructor: (@el) ->

  render: (remaining) ->
    template = require '../templates/game/timer.haml'
    @el.html template({'remaining': remaining})


module.exports = TimerView
