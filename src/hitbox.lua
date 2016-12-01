
local Vector = require 'basic.vector'

local hitbox = {}

function hitbox.new (width, height, ox, oy)
  local self = require 'basic.physics.collision_area' :new {
    0, 0, width, height, centred = true,
  }

  self.offset = Vector:new { ox, oy }

  function self:set_pos (x, y)
    local position = Vector:new { x, y } - self.offset
    self.pos:set(position:unpack())
  end

  return self
end

return hitbox
