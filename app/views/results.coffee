class ResultsView
  constructor: (@el) ->
  
  render: (elapsed) ->
    template = require '../templates/game/results.haml'
    @el.html template({score: elapsed})


module.exports = ResultsView
