
local Model = require 'model'
local Component = require 'component'

function Actor (params)
  local self = Component.inherit()

  local maxhp, attack
  local damage

  function self:init ()
    maxhp, attack = params.maxhp, params.attack
    damage = 0
  end

  function self:is_dead ()
    return damage >= maxhp
  end

  function self:get_max_hp ()
    return maxhp
  end

  function self:get_current_hp ()
    return maxhp - damage
  end

  function self:update ()
    if self:is_dead() then
      Signal:emit('dead', self:get_id())
    end
  end

  function self:draw ()

  end

  return self
end

return Model(Actor)
