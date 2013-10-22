View = require './view.coffee'


class IndexView extends View
  render: ->
    template = require '../templates/index.haml'
    @el.html(template())


module.exports = IndexView
