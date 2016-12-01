
local Model = require 'model'
local Component = require 'component'

function Attack (params)
  local self = Component.inherit()

  -- add attributes here, like this:
  local value
  local priority

  function self:init()
    value = params.value or 1
    priority = params.priority or 1
  end

  function self:get_value ()
    return value
  end

  function self:get_priority ()
    return priority
  end

  function self:update()
    -- update
  end

  function self:draw()
    -- draw
  end

  return self
end

return Model(Attack, 'attack')
