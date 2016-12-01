
local Model = require 'model'
local Component = require 'component'

function Actor (params)
  local self = Component.inherit()

  local name
  local maxhp
  local damage

  function self:init ()
    name = params.name
    maxhp = params.maxhp
    damage = 0
  end

  function self:get_name ()
    return name
  end

  function self:take_dmg(dmg)
    print(damage, dmg)
    damage = math.min(damage + dmg, maxhp)
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

return Model(Actor, 'actor')
