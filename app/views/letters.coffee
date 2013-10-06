class LettersView
  constructor: (@el, @parent) ->
  
  render: (sequence) ->
    template = require '../templates/game/letters.haml'
    @el.html template({sequence: sequence})
    @el.find('.letter').animate({'opacity': 1.0}, 250)

module.exports = LettersView
