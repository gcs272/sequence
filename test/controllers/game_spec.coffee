require '../setup.coffee'

$         = require 'jqueryify'
expect    = require('chai').expect
prequire  = require 'proxyquire'


describe 'Game Controller', ->
  beforeEach ->
    class MockTimerView
      constructor: (@el) ->
      render: (remaining) ->

    class MockLettersView
      constructor: (@el) ->
      render: (@sequence) ->

    document.write """<div class="container contents"></div>"""

    deferred = $.Deferred()
    GameController = prequire 'controllers/game.coffee',
      '../views/timer.coffee': MockTimerView
      '../views/letters.coffee': MockLettersView

    GameController.loadAssets = () ->
      deferred

    @controller = new GameController($('.contents'))
    @controller.render()

    deferred.done()
    @controller.words = ['stuff', 'things', 'stratified']
    @controller.sequences = ['stf']

  it 'should have jquery in tests', ->
    expect($.find('.contents')).to.have.length 1

  it 'should start a game', ->
    @controller.start()
    expect(@controller.game).to.exist
