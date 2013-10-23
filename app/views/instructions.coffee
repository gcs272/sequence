View = require './view.coffee'

class InstructionsView extends View
  render: ->
    template = require '../templates/instructions.haml'
    @el.html(template())

module.exports = InstructionsView
