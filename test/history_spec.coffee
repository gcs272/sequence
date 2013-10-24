expect = require('chai').expect

History = require 'history.coffee'

describe 'History module', ->
  describe 'After a few rounds', ->
    beforeEach ->
      @history = new History()
      @history.push
        sequence: 'aaa'
        guess: 'aardvark'
        correct: true
      @history.push
        sequence: 'zzz'
        guess: ''
        correct: false
      @history.push
        sequence: 'stf'
        guess: 'stuff'
        correct: true
      @history.push
        sequence: 'stf'
        guess: 'stratified'
        correct: true
      @history.push
        sequence: 'abc'
        guess: 'nope'
        correct: false

    it 'should give the best word', ->
      expect(@history.bestWord()).to.equal 'stratified'

    it 'should provide a breakdown', ->
      breakdown = @history.breakdown()
      expect(breakdown.correct).to.equal 3
      expect(breakdown.incorrect).to.equal 1
      expect(breakdown.skipped).to.equal 1
