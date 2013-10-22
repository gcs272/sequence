View = require './view.coffee'

class ResultView extends View
  render: (word, correct) ->
    template = require '../templates/game/result.haml'
    @el.html template
      word: word
      correct: correct

module.exports = ResultView
