View = require './view.coffee'

class ResultsView extends View
  render: (score, elapsed, bestWord, breakdown) ->
    template = require '../templates/game/results.haml'
    @el.html template
      score: score
      elapsed: elapsed
      bestWord: bestWord
      breakdown: breakdown
    @el.find('.again').click =>
      @trigger('again')

module.exports = ResultsView
