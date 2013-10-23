InstructionsView = require '../views/instructions.coffee'

class InstructionsController
  constructor: (@el) ->

  render: ->
    @view = new InstructionsView(@el)
    @view.render()

module.exports = InstructionsController
