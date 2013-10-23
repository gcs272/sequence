View = require './view.coffee'

class AboutView extends View
  render: ->
    template = require '../templates/about.haml'
    @el.html(template())

module.exports = AboutView
