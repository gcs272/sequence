class Game
  constructor: (@words, @sequences) ->
    # Hack: shouldnt have to exist, but tests recycle @_events on objects
    @_events = {}

  start: ->
    @multiplier = 1.0
    @score = 0
    @clock = 60
    @elapsed = 0
    @clockInterval = setInterval @tick, 1000
    @newSequence()
    @trigger 'tick'

  tick: =>
    @clock -= 1
    @elapsed += 1
    if @clock <= 0
      @trigger('end')

    @trigger('tick')

  newSequence: ->
    @sequence = @sequences[Math.floor(Math.random() * @sequences.length)]
    @trigger 'sequence-start', @sequence

  guess: (word) ->
    result = @isSolution word
    if result
      @score += word.length * 10 * @multiplier
      @clock += word.length
      @multiplier = if @multiplier >= 3.0 then 3.0 else @multiplier + 0.2
      @trigger 'correct', word
    else
      @clock -= 2
      @multiplier = 1.0
      @trigger 'incorrect', word

    @newSequence()
    result

  isSolution: (word) ->
    candidate = word.toLowerCase().trim()
    if candidate not in @words or not word?
      return false
    
    for char in @sequence
      if char not in candidate
        return false
      candidate = candidate[candidate.indexOf(char)..].toString()

    true

  destroy: ->
    clearInterval(@clockInterval)

  on: (event, fn) ->
    @_events[event] = fn
  
  trigger: (event, args) ->
    event of @_events and @_events[event](if args? then args else null)


module.exports = Game
