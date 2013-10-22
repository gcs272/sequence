View = require './view.coffee'

class ScoreView extends View
  render: (score) ->
    template = require '../templates/game/score.haml'
    @el.html template
      score: score

module.exports = ScoreView
