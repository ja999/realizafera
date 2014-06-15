Array::insertAt = (index, item) ->
  @splice(index, 0, item)
  @

Number::times = (fn) ->
  val = @valueOf()
  do fn for [1..val] if val > 0
  return

