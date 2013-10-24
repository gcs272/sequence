expect = require('chai').expect

Game = require 'game.coffee'


describe 'Game Module', ->
  describe 'After the game has started', ->
    beforeEach ->
      @game = new Game ['stuff', 'stratify', 'junk'], {'stf': 2}
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

    it 'should log guesses', ->
      expect(@game.history).to.exist
      @game.guess 'stuff'

      expect(@game.history).to.have.length 1
      first = @game.history[0]
      expect(first.sequence).to.equal 'stf'
      expect(first.guess).to.equal 'stuff'

      @game.sequence = 'str'
      @game.guess 'nope'

      expect(@game.history).to.have.length 2
      second = @game.history[1]
      expect(second.sequence).to.equal 'str'
      expect(second.guess).to.equal 'nope'
      expect(second.correct).to.equal false

  describe 'Every second', ->
    beforeEach ->
      @game = new Game ['stuff', 'stratify', 'junk'], {'stf': 2}
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

  describe 'Guessing', ->
    beforeEach ->
      @game = new Game ['stuff', 'stratify', 'junk'], {'stf': 2000}
      @game.start()

    it 'should keep a basic score', ->
      @game.guess('stuff')
      expect(@game.score).to.equal 50

    it 'should add a multiplier on subsequent correct guesses', ->
      @game.guess('stuff')
      expect(@game.score).to.equal 50

      @game.guess('stuff')
      expect(@game.score).to.equal 110

      @game.guess('stuff')
      expect(@game.score).to.equal 180

      @game.guess('shenanigans')
      expect(@game.score).to.equal 180

      @game.guess('stuff')
      expect(@game.score).to.equal 230

    it 'should cap the multiplier at 3', ->
      @game.multiplier = 2.8
      @game.guess('stuff')
      expect(@game.multiplier).to.equal 3.0

      @game.guess('stuff')
      expect(@game.multiplier).to.equal 3.0

  describe 'Score multiplication', ->
    it 'should multiply a basic score', ->
      @game = new Game ['stratify'], {'stf': 2000}
      @game.start()

      @game.guess('stratify')
      expect(@game.score).to.equal 80

    it 'should multiply out a difficult score', ->
      @game = new Game ['stratify'], {'stf': 1}
      @game.start()

      @game.guess('stratify')
      expect(@game.score).to.equal 800

    it 'should stack difficulty and multipliers', ->
      @game = new Game ['stratify'], {'stf': 1}
      @game.start()
      @game.multiplier = 3.0

      @game.guess('stratify')
      expect(@game.score).to.equal 2400

  describe 'Difficulty', ->
    beforeEach ->
      @seqs =
        'aaa': 4000
        'aab': 250
        'aac': 150
        'aad': 20
        'aae': 12
        'aaf': 1
      @game = new Game [], @seqs

    it 'should grade from one to ten', ->
      expect(@game.getDifficulty 'aaa').to.equal 1
      expect(@game.getDifficulty 'aaf').to.equal 10

    it 'should separate closely graded sequences', ->
      aaa = @game.getDifficulty 'aaa'
      aab = @game.getDifficulty 'aab'
      aac = @game.getDifficulty 'aac'
      aad = @game.getDifficulty 'aad'
      aae = @game.getDifficulty 'aae'
      aaf = @game.getDifficulty 'aaf'

      expect(aaa).to.be.lessThan aab
      expect(aab).to.be.lessThan aac
      expect(aac).to.be.lessThan aad
      expect(aad).to.be.lessThan aae
