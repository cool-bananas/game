
local dice = {}

function dice.throw (times, sides)
  local result = 0

  for i = 1, times do
    result = result + math.random(1, sides)
  end

  return result
end

return dice
