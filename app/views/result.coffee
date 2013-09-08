class ResultView
  constructor: (@el) ->

  render: (word, correct) ->
    template = require '../templates/game/result.haml'
    @el.html template
      word: word
      correct: correct


module.exports = ResultView
