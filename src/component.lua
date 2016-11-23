
local Component = {}

function Component.inherit ()
  local obj = {}

  -- attributes
  local id = false

  function obj:set_id (new_id)
    id = new_id
  end

  function obj:get_id ()
    return id
  end

  function obj:init ()
    -- implement on child
  end

  function obj:update ()
    -- implement on child
  end

  function obj:draw ()
    -- implement on child
  end

  function obj:destroy ()
    -- implement on child
  end

  return obj
end

return Component
