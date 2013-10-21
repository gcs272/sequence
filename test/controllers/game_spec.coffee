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
    @controller.sequences =
      'stf': 2

  it 'should have jquery in tests', ->
    expect($.find('.contents')).to.have.length 1

  it 'should start a game', ->
    @controller.start()
    expect(@controller.game).to.exist

  it 'should display results on a guess', ->
    @controller.start()
    @controller.guess('stuff')

    expect($('.score').html()).to.contain 'Score: 50'
    expect($('.result').html()).to.contain 'stuff +5s'
    expect($('.multiplier').html()).to.contain '1.2x'

  describe 'When the game finished', ->
    it 'should show the score and elapsed time', ->
      @controller.start()
      @controller.game.score = 100
      @controller.game.elapsed = 90
      @controller.gameOver()

      html = $('.timer').html()
      expect(html).to.contain 'Final Score: 100'
      expect(html).to.contain '90 seconds'
