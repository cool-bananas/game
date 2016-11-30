
local Model = require 'model'
local Component = require 'component'

local Vector = require 'basic.vector'
local CollisionArea = require 'basic.physics.collision_area'

function Hitbox (params)
  local self = Component.inherit()

  local collision_area = CollisionArea:new(table.copy(params.collision_area or {}))
  local offset = Vector:new(params.offset)

  function self:init()
    --
  end

  function self:get_collision_area ()
    return collision_area
  end

  function self:set_position (x, y)
    local position = Vector:new { x, y } + offset
    x, y = position:unpack()
    collision_area:set_pos(x, y)
  end

  function self:get_position ()
    return collision_area:get_pos()
  end

  function self:update()
    Signal:emit("update_hitbox", self:get_id())
  end

  function self:print ()
    print("I AM A HITBOX GODDAMMIT")
  end

  function self:draw()
    local t, r, b, l = collision_area:get_edges()
    love.graphics.setColor(255, 0, 0, 120)
    love.graphics.rectangle( 'fill', l, t, r - l, b - t)
    love.graphics.setColor(255,255,255)
  end

  -- add your own methods too!

  return self
end

return Model(Hitbox, 'hitbox')
