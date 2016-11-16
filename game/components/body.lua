
local Model = require 'model'
local Component = require 'component'

local G = require 'basic.vector' :new { 0, 10 }

function Body (params)
  local self = Component.inherit()

  function self:init ()
    -- initializer
    params.EPSILON = 1
    self.physics = require 'basic.physics.dynamic_body' :new (params)
  end

  function self:update ()
    -- logic update
    self.physics:move(G)
    self.physics:update()
    self:check_limits()
  end

  function self:check_limits()
    local pos = self.physics:get_pos()
    local size = self.physics:get_size()

    if pos.y + size.y / 2 > Globals.height - 128 then
      self.physics:set_pos(pos.x, Globals.height - 128 - size.y / 2)
      self.physics:set_speed()
    end
    if pos.x - size.x / 2 < 0 then
      self.physics:set_pos(0 + size.x / 2, pos.y)
    end
    if pos.x + size.x / 2 > Globals.width then
      self.physics:set_pos(Globals.width - size.x / 2, pos.y)
    end
  end

  function self:draw ()
    -- render update
    local pos = self.physics:get_pos()
    local size = self.physics:get_size()

    love.graphics.setColor(255,255,255)
    love.graphics.rectangle('fill', pos.x - size.x / 2, pos.y - size.y / 2, size.x, size.y)
  end

  function self:destroy ()
    -- what happens when you destroy
  end

  return self
end

return Model(Body)
