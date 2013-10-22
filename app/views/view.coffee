class View
  constructor: (@el) ->
    @_events = {}

  on: (event, fn) ->
    @_events[event] = fn

  trigger: (event, args) ->
    event of @_events and @_events[event](if args? then args else null)


module.exports = View
