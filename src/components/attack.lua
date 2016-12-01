
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
    Timer:after(
      params.length,
      function ()
        print("ATTACK IS DONE!")
        local Manager = require 'manager'
        Manager:delete_element(self:get_id())
      end
    )
  end

  function self:get_value ()
    return value
  end

  function self:get_priority ()
    return priority
  end

  function self:update()
    print("ATTACKING!")
  end

  function self:draw()
    -- draw
  end

  return self
end

return Model(Attack, 'attack')
