expect = require('chai').expect

Game = require 'game.coffee'


describe 'Game Module', ->
  beforeEach ->
    @game = new Game ['stuff'], ['stf']

  it 'should put 60 seconds on the clock', ->
    @game.start()

    expect(@game.clock).to.equal 60

  it 'should set the current sequence on game start', ->
    expect(@game.sequence?).to.equal false
    @game.start()
    expect(@game.sequence?).to.equal true
    expect(@game.sequence).to.equal 'stf'
