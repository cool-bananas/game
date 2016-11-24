
local Model = require 'model'
local Component = require 'component'

local barsize = 255

function Lifebar (params)
  local self = Component.inherit()

  local pos = require 'basic.vector' :new {}
  local actor
  local maxhp, current

  function self:set_actor (a)
    actor = a
  end

  function self:set_pos (x, y)
    pos:set(x, y)
  end

  function self:update ()
    if actor then
      maxhp = actor:get_max_hp()
      current = actor:get_current_hp()
    end
  end

  function self:draw ()
    love.graphics.setColor(30,30,30)
    love.graphics.rectangle("fill", pos.x - barsize / 2 - 1, pos.y - 1, barsize + 2, 12)
    love.graphics.setColor(0,200,0)
    love.graphics.rectangle("fill", pos.x - barsize / 2, pos.y, barsize * current / maxhp, 10)
  end

  return self
end

return Model(Lifebar)
