View = require './view.coffee'

class LettersView extends View
  render: (sequence, difficulty) ->
    template = require '../templates/game/letters.haml'

    classname = switch
      when difficulty < 4 then 'label-success'
      when difficulty < 8 then 'label-warning'
      else 'label-danger'

    @el.html template
      sequence: sequence
      difficulty: difficulty
      classname: classname

    @el.find('.letter').animate({'opacity': 1.0}, 250)

module.exports = LettersView
