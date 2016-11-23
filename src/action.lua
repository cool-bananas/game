
local Action = {}

function Action.inherit ()
  local self = {}

  local actions = {}

  function self:add (n, f)
    table.insert(actions, { name = n, call = f })
  end

  function self:on ()
    for k, act in pairs(actions) do
      Signal:register(act.name, act.call)
    end
  end

  function self:off ()
    for k, act in pairs(actions) do
      Signal:remove(act.name, act.call)
    end
  end

  return self
end

return Action
