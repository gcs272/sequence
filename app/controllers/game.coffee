GuessView =     require '../views/guess.coffee'
LettersView =   require '../views/letters.coffee'
TimerView =     require '../views/timer.coffee'
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
    @guessView = new GuessView(@el.find('.word'), @)
    @guessView.render()
    @el.find('input').focus()

    @lettersView = new LettersView(@el.find('.letters'), @)
    @newSequence()

    @clock = 60
    @elapsed = 0
    @clockInterval = setInterval @tick, 1000
    @timerView = new TimerView(@el.find('.timer'))
    @timerView.render(@clock)

  tick: =>
    @clock -= 1
    @elapsed += 1

    if @clock <= 0
      @destroy()
      @render()
      @gameOver()

    @timerView.render(@clock)

  newSequence: ->
    @sequence = @sequences[Math.floor(Math.random() * @sequences.length)]
    @lettersView.render(@sequence)

  isSolution: (word) ->
    if word not in @words
      return false

    for char in @sequence
      if char not in word
        return false
      word = word[word.indexOf(char)..].toString()

    true

  guess: (word) ->
    if @isSolution(word)
      @score(word.length)
    else
      @score(-2)
    @newSequence()

  score: (update) ->
    @clock += update
    @timerView.render(@clock)

  render: ->
    template = require '../templates/game/layout.haml'
    @el.html(template())

  destroy: ->
    clearInterval(@clockInterval)

  gameOver: ->
    @resultsView = new ResultsView(@el.find('.timer'))
    @resultsView.render(@elapsed)

module.exports = GameController
