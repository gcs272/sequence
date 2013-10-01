require '../setup.coffee'

expect  = require('chai').expect
$       = require('jqueryify')


GameController = require 'controllers/game.coffee'


describe 'Game Controller', ->
  beforeEach ->
    document.write """
        <div class="container contents"></div>
    """

    deferred = $.Deferred()
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
