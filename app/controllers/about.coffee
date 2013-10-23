AboutView = require '../views/about.coffee'

class AboutController
  constructor: (@el) ->

  render: ->
    @view = new AboutView(@el)
    @view.render()

module.exports = AboutController
