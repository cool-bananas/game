
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

  function self:update ()
    if self:is_dead() then
      Signal:emit('dead', self:get_id())
    end
  end

  return self
end

return Model(Actor)
