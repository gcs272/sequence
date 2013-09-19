Game = require '../game.coffee'

GuessView =     require '../views/guess.coffee'
LettersView =   require '../views/letters.coffee'
TimerView =     require '../views/timer.coffee'
ResultView =    require '../views/result.coffee'
ResultsView =   require '../views/results.coffee'

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
    @game = new Game @words, @sequences

    @guessView = new GuessView(@el.find('.word'), @)
    @guessView.render()
    @el.find('input').focus()

    @resultView = new ResultView(@el.find('.result'))
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
      @lettersView.render sequence

    @game.on 'correct', (word) =>
      @resultView.render word, true

    @game.on 'incorrect', (word) =>
      @resultView.render word, false

    @game.start()

  guess: (word) ->
    @game.guess word

  render: ->
    template = require '../templates/game/layout.haml'
    @el.html(template())

  destroy: ->
    @game.destroy()

  gameOver: ->
    @resultsView = new ResultsView(@el.find('.timer'))
    @resultsView.render(@game.elapsed)


module.exports = GameController
