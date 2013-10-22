View = require './view.coffee'

class ResultsView extends View
  render: (score, elapsed) ->
    template = require '../templates/game/results.haml'
    @el.html template({score: score, elapsed: elapsed})
    @el.find('.again').click =>
      @trigger('again')

module.exports = ResultsView
