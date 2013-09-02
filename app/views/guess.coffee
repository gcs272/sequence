class GuessView
  constructor: (@el, @parent) ->
  
  render: ->
    template = require '../templates/game/guess.haml'
    @el.html(template())

    @el.find('form').bind 'submit', (e) =>
      e?.preventDefault()
      @parent.guess(@el.find('input').val())
      @el.find('input').val('')

module.exports = GuessView
