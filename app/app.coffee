Router  = require('director').Router
$       = require 'jqueryify'

IndexController = require './controllers/index.coffee'
GameController  = require './controllers/game.coffee'


class App
  constructor: ->
    @el = $('.contents')

  index: =>
    @activate(new IndexController(@el))

  arcade: =>
    @activate(new GameController(@el))

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
  router.init('/')
)
