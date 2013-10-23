Router  = require('director').Router
$       = require 'jqueryify'

GameController          = require './controllers/game.coffee'
IndexController         = require './controllers/index.coffee'
InstructionsController  = require './controllers/instructions.coffee'


class App
  constructor: ->
    @el = $('.contents')

  index: =>
    @activate new IndexController(@el)

  arcade: =>
    @activate new GameController(@el)

  instructions: =>
    @activate new InstructionsController(@el)

  activate: (controller) ->
    if @controller?.destroy?
      @controller.destroy()

    @el.html('')
    @controller = controller
    @controller.render()

$(() ->
  app = new App()
  router = new Router
    '': app.index,
    '/arcade': app.arcade
    '/instructions': app.instructions
  router.init('/')
)
