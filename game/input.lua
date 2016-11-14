

-- INPUT DEFAULT VALUES

local p1_keymap = {
  -- p1
  up     = 'up',
  down   = 'down',
  left   = 'left',
  right  = 'right',
  z      = 'A',
  x      = 'B',
  c      = 'C',
  f8     = 'quit',
  escape = 'pause',
}

local p2_keymap = {
  -- p2
  w      = 'up',
  s      = 'down',
  a      = 'left',
  d      = 'right',
  b      = 'A',
  n      = 'B',
  m      = 'C',
  f9     = 'quit',
  p      = 'pause',
}


-- INPUT HANDLER (all input is translated into signals)

local handle = {
  hold = function (player, actions)
    Signal:emit(player .. '_hold', actions)
  end,
  press = function (player, action)
    Signal:emit(player .. '_ṕress', action)
  end,
  release = function (player, action)
    Signal:emit(player .. '_release', action)
  end,
}


-- INPUT MODULE

local input = {}

-- save held actions in a hash table
input.p1_held_actions = {}
input.p2_held_actions = {}


function input.keyheld (player)
  --[[ (string) -> void
  Receives a string value that must be either 'p1' or 'p2'.
  Checks which valid actions are currently being held.
  Then calls input handler at the end. ]]

  local keymap = input[player .. '_keymap']
  local held_actions = held_actions
  local idle = true

  for key, action in pairs(keymap) do
    held_actions[action] = love.keyboard.isDown(key)
    idle = idle and not held_actions[action]
  end
  held_actions.idle = idle

  handle.hold(player, held_actions)
end


function input.keypressed (key)
  --[[ (string) -> void
  Called everytime a key is pressed via the function `love.keypressed()`.
  Receives a key value in string format.
  Check love2D's documentation for valid key values.
  Checks if the key is registered as an action,
  and then calls the handler if it is. ]]

  if input.p1_keymap[key] then
    handle.press('p1', input.p1_keymap[key])
  end
  if input.p2_keymap[key] then
    handle.press('p2', input.p2_keymap[key])
  end
end

function input.keyreleased (key)
  --[[ (string) -> void
  Called everytime a key is released via the function `love.keyreleased()`.
  Receives a key value in string format.
  Check love2D's documentation for valid key values.
  Checks if the key is registered as an action,
  and then calls the handler if it is. ]]

  if input.p1_keymap[key] then
    handle.press('p1', input.p1_keymap[key])
  end
  if input.p2_keymap[key] then
    handle.press('p2', input.p2_keymap[key])
  end
end

function input.set_action_key (player, key, action)
  --[[ (string, string, string) -> void
  Receives a 'p1'/'p2' string, a key value string, and an action's name.
  Attributes a new key to an action. Removes old keybinding. ]]

  local keymap = input[player .. '_keymap']
  for k, act in pairs(keymap) do
    if act == action then
      keymap[k] = nil
      keymap[key] = action
    end
  end
end

function input.get_action_key (player, action)
  --[[ (string, string) -> string
  Receives a 'p1'/'p2' string and an action's name.
  Returns the key value associated with the action's name. ]]

  local keymap = input[player .. '_keymap']
  for k, act in pairs(keymap) do
    if act == action then
      return k
    end
  end
end

function input.load ()
  --[[ () -> void
  Should be called as soon as the module is required.
  Loads either the default or saved values for keymapping. ]]

  -- try to load saved value first
  -- [ NOT IMPLEMENTED YET ]

  -- if loading saved profile failed, then load default values
  input.p1_keymap = p1_keymap
  input.p2_keymap = p2_keymap
end

function input.update ()
  --[[ () -> void
  Updates input logic.
  Exists for checking held actions. ]]

  input.keyheld('p1')
  input.keyheld('p2')
end

return input
