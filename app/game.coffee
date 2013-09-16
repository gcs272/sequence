class Game
  constructor: (@words, @sequences) ->

  start: ->
    @clock = 60
    @elapsed = 0
    @clockInterval = setInterval @tick, 1000
    @newSequence()

  newSequence: ->
    @sequence = @sequences[Math.floor(Math.random() * @sequences.length)]
    @sequence

  isSolution: (word) ->
    if word not in @words
      false
    
    for char in @sequence
      if char not in word
        false
      word = word[word.indexOf(char)..].toString()

    true


module.exports = Game
