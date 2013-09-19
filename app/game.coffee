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
    candidate = word.toLowerCase().trim()
    if candidate not in @words or not word?
      return false
    
    for char in @sequence
      if char not in candidate
        return false
      candidate = candidate[candidate.indexOf(char)..].toString()

    true


module.exports = Game
