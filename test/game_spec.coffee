expect = require('chai').expect

Game = require 'game.coffee'


describe 'Game Module', ->
  describe 'After the game has started', ->
    beforeEach ->
      @game = new Game ['stuff', 'stratify', 'junk'], ['stf']
      @game.start()

    it 'should put 60 seconds on the clock', ->
      expect(@game.clock).to.equal 60

    it 'should set the current sequence on game start', ->
      expect(@game.sequence?).to.equal true
      expect(@game.sequence).to.equal 'stf'

    it 'should check solutions', ->
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

    it 'should add to the clock on a correct guess', ->
      expect(@game.clock).to.equal 60

      @game.guess 'stuff'
      expect(@game.clock).to.equal 65

    it 'should subtract 2s on a bad guess', ->
      expect(@game.clock).to.equal 60
      @game.guess 'shenanigans'
      expect(@game.clock).to.equal 58

  describe 'Every second', ->
    beforeEach ->
      @game = new Game ['stuff', 'stratify', 'junk'], ['stf']
      @game.start()

    it 'should reduce the clock', ->
      @game.tick()
      expect(@game.clock).to.equal 59

    it 'should check if the game ended', (done) ->
      @game.clock = 1
      
      @game.on 'end', ->
        done()

      @game.tick()

    it 'should emit a tick event', (done) ->
      @game.on 'tick', ->
        done()
      @game.tick()

    it 'should add a second to elapsed', ->
      @game.tick()
      expect(@game.elapsed).to.equal 1
