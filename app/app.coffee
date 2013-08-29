Router  = require('director').Router
$       = require 'jqueryify'

IndexController = require './controllers/index.coffee'

$(() ->
  el = $('.contents')

  index = ->
    controller = new IndexController(el)
    controller.render()

  router = new Router
    '': index

  router.init('/')
)
