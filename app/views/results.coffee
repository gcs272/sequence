class ResultsView
  constructor: (@el) ->
  
  render: (score, elapsed) ->
    template = require '../templates/game/results.haml'
    @el.html template({score: score, elapsed: elapsed})


module.exports = ResultsView
