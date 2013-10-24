$ = require 'jqueryify'

Game = require '../game.coffee'

GuessView =       require '../views/guess.coffee'
LettersView =     require '../views/letters.coffee'
MultiplierView =  require '../views/multiplier.coffee'
ResultView =      require '../views/result.coffee'
ResultsView =     require '../views/results.coffee'
ScoreView =       require '../views/score.coffee'
TimerView =       require '../views/timer.coffee'

class GameController
  constructor: (@el) ->
    @loadAssets().done =>
      @start()

  loadAssets: ->
    deferred = $.Deferred()
    $.get('/assets/words.json').done (words) =>
      @words = words
      $.get('/assets/sequences.json').done (sequences) =>
        @sequences = sequences
        deferred.resolve()
    deferred

  start: ->
    @el.find('.results').html('')
    @game = new Game @words, @sequences

    @guessView = new GuessView(@el.find('.word'), @)
    @guessView.render()
    @el.find('input').focus()

    @multiplierView = new MultiplierView(@el.find('.multiplier'))
    @resultView = new ResultView(@el.find('.result'))
    @scoreView = new ScoreView(@el.find('.score'))
    @lettersView = new LettersView(@el.find('.letters'), @)
    @timerView = new TimerView(@el.find('.timer'))

    @game.on 'tick', =>
      @timerView.render(@game.clock)

    @game.on 'end', =>
      @destroy()
      @render()
      @gameOver()

    @game.on 'sequence-start', (sequence) =>
      @timerView.render(@game.clock)
      @lettersView.render sequence, @game.getDifficulty(sequence)

    @game.on 'correct', (word) =>
      @scoreView.render @game.score
      @resultView.render word, true
      @multiplierView.render @game.multiplier

    @game.on 'incorrect', (word) =>
      @scoreView.render @game.score
      @resultView.render word, false
      @multiplierView.render @game.multiplier

    @game.start()

  guess: (word) ->
    @game.guess word

  render: ->
    template = require '../templates/game/layout.haml'
    @el.html(template())

  destroy: ->
    @game.destroy()

  gameOver: ->
    @resultsView = new ResultsView(@el.find('.results'))
    @resultsView.render @game.score, @game.elapsed, @game.history.bestWord(),
      @game.history.breakdown()
    @resultsView.on 'again', =>
      @start()


module.exports = GameController
