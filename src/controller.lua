
local controller = require 'basic.prototype' :new {
  {},
  __type = 'controller',
}

function controller:__init ()
  local listname = self[1]
  local list = require 'database.actions' [listname]

  self.registered = {}
  for k, ctrl_name in pairs(list) do
    self:attach(ctrl_name)
  end
end

function controller:attach (name)
  local success, ctrl = pcall(require, 'actions.' .. name)
  if success then
    self.registered[name] = ctrl
  else
    print(ctrl)
  end
end

function controller:activate ()
  print('controller activated')
  for k, ctrl in pairs(self.registered) do
    ctrl:on()
  end
end

function controller:deactivate ()
  for k, ctrl in pairs(self.registered) do
    ctrl:off()
  end
end

return controller
