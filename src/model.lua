
-- dependency
local pool = require 'basic.pool'

return function (constructor, name)
  local self = {}

  self.list = {}
  self.construct = constructor
  self.name = name or 'model'

  local bogus = constructor {}

  function self.get (id)
    for _,object in pairs(self.list) do
      if object:get_id() == id then
        return object
      end
    end
    --return bogus
  end

  function self.create (id, params)
    local object = self.construct(params)
    object:set_id(id)
    object:init()
    pool.add(self.list, object)
    return object
  end

  function self.destroy (id)
    for k, object in pairs(self.list) do
      if object:get_id() == id then
        object:destroy()
        pool.remove(self.list, k)
      end
    end
  end

  function self.update ()
    Signal:emit('model_update', self.name)
    for _, object in pairs(self.list) do
      object:update()
    end
    Signal:emit('model_update_done', self.name)
  end

  function self.draw ()
    for _, object in pairs(self.list) do
      object:draw()
    end
  end

  return self
end
