class LettersView
  constructor: (@el, @parent) ->
  
  render: (sequence) ->
    template = require '../templates/game/letters.haml'
    @el.html template({sequence: sequence})


module.exports = LettersView
