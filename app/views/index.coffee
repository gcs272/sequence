class IndexView
  constructor: (@el) ->

  render: ->
    template = require '../templates/index.haml'
    @el.html(template())


module.exports = IndexView
