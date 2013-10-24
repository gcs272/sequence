class History
  constructor: ->
    @rounds = []

  push: (round) ->
    @rounds.push round

  bestWord: ->
    best = ''
    for round in @rounds
      if round.correct and round.guess.length > best.length
        best = round.guess

    if best.length > 0 then best else null

  breakdown: ->
    b =
      correct: 0
      incorrect: 0
      skipped: 0
    for round in @rounds
      switch
        when round.correct then b.correct += 1
        when round.guess == '' then b.skipped += 1
        else b.incorrect += 1

    b

module.exports = History
