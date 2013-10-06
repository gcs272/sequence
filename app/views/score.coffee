class ScoreView
  constructor: (@el) ->
  
  render: (score) ->
    template = require '../templates/game/score.haml'
    @el.html template
      score: score

module.exports = ScoreView
