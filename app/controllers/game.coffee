GuessView = require '../views/guess.coffee'
LettersView = require '../views/letters.coffee'


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

    @lettersView = new LettersView(@el.find('.letters'), @)
    @newSequence()

  newSequence: ->
    @sequence = @sequences[Math.floor(Math.random() * @sequences.length)]
    @lettersView.render(@sequence)

  isSolution: (word) ->
    if not word in @words
      return false

    for char in @sequence
      if char not in word
        return false
      word = word[word.indexOf(char)..].toString()

    true

  guess: (word) ->
    if @isSolution(word)
      console.log 'solved!'
    else
      console.log 'nope!'
    @newSequence()

  render: ->
    template = require '../templates/game/layout.haml'
    @el.html(template())

  destroy: ->
    console.log 'destroying game'

module.exports = GameController
