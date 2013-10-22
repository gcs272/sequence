View = require './view.coffee'

class TimerView extends View
  render: (remaining) ->
    template = require '../templates/game/timer.haml'
    @el.html template({'remaining': remaining})

    @gauge = new Gauge(@el)
    @gauge.render(remaining / 60)

class Gauge extends View
  constructor: (@el) ->
  
  render: (value) ->
    canvas = @el.find('.gauge')[0]
    ctx = canvas.getContext('2d')
    ctx.beginPath()
    radius = (canvas.height / 2) * 0.8

    ctx.lineWidth = 18
   

    if value < 0.5
      red = Math.round((1.0 - value) * 255).toString(16)
      ctx.strokeStyle = "##{red}0000"

    ctx.arc(canvas.width / 2, canvas.height / 2, radius, 0, value * 2.0 * Math.PI)
    ctx.stroke()
    ctx.closePath()

    if value > 1.0
      ctx.beginPath()
      ctx.lineWidth = 14
      ctx.strokeStyle = '#0099cc'
      ctx.arc(canvas.width / 2, canvas.height / 2, radius, 0, (value - 1.0) * 2.0 * Math.PI)
      ctx.stroke()
      ctx.closePath()


module.exports = TimerView
