
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
    local speed = self.physics:get_speed()
    local size = self.physics:get_size()
    local top, right, bottom, left = self.physics:get_edges()

    if bottom > Globals.height - 128 then
      self.physics:set_pos(pos.x, Globals.height - 128 - size.y / 2)
      self.physics:set_speed(speed.x, 0)
    end

    local pos = self.physics:get_pos()

    if left < 0 then
      self.physics:set_pos(size.x / 2, pos.y)
    end
    if right > Globals.width then
      self.physics:set_pos(Globals.width - size.x / 2, pos.y)
    end
  end

  function self:draw ()
    -- render update
    local pos = self.physics:get_pos()
    local size = self.physics:get_size()

    love.graphics.rectangle('fill', pos.x - size.x / 2, pos.y - size.y / 2, size.x, size.y)
  end

  function self:destroy ()
    -- what happens when you destroy
  end

  print(self)
  return self
end

return Model(Body)
