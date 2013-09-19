expect = require('chai').expect

Game = require 'game.coffee'


describe 'Game Module', ->
  beforeEach ->
    @game = new Game ['stuff', 'stratify', 'junk'], ['stf']

  it 'should put 60 seconds on the clock', ->
    @game.start()

    expect(@game.clock).to.equal 60

  it 'should set the current sequence on game start', ->
    expect(@game.sequence?).to.equal false
    @game.start()
    expect(@game.sequence?).to.equal true
    expect(@game.sequence).to.equal 'stf'

  it 'should check solutions', ->
    @game.start()
    expect(@game.sequence).to.equal 'stf'

    expect(@game.isSolution('stuff')).to.equal true
    expect(@game.isSolution('stratify')).to.equal true
    expect(@game.isSolution('Stuff')).to.equal true
    expect(@game.isSolution('StRaTiFY')).to.equal true

    expect(@game.isSolution('junk')).to.equal false
    expect(@game.isSolution('stratification')).to.equal false
    expect(@game.isSolution('stuf')).to.equal false
    expect(@game.isSolution('')).to.equal false
    expect(@game.isSolution('0')).to.equal false
