IndexView = require '../views/index.coffee'

class IndexController
  constructor: (@el) ->

  render: ->
    @view = new IndexView(@el)
    @view.render()


module.exports = IndexController
