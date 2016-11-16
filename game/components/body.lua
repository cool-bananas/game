
local Model = require 'model'
local Component = require 'component'

function Body (params)
  local self = Component.inherit()

  -- attributes
  local pos = require 'basic.vector' :new {
    math.random(0, Globals.width - 50),
    math.random(0, Globals.height - 50),
  }

  function self:init ()
    -- initializer
  end

  function self:update ()
    -- logic update
  end

  function self:draw ()
    -- render update
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle('fill', pos.x, pos.y, 50, 50)
  end

  function self:destroy ()
    -- what happens when you destroy
  end

  return self
end

return Model(Body)
