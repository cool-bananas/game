
local input = {}

input.direction = {
  -- p1 directions 1, 2, 3, 4, 5
  'up1',
  'down1',
  'left1',
  'right1',
  'idle1',
  -- p2 directions 6, 7, 8, 9, 10
  'up2',
  'down2',
  'left2',
  'right2',
  'idle2',
}

input.action = {
  -- p1 actions 1, 2, 3, 4, 5
  'A1',
  'B1',
  'C1',
  'quit1',
  'pause1',
  -- p2 actions 6, 7, 8, 9, 10
  'A2',
  'B2',
  'C2',
  'quit2',
  'pause2',
}

local handle = {
  -- input types: press, release, hold
  action = function (input_type, id)
    Signal:emit('input_' .. input_type, input.action[id])
  end,
  direction = function (input_type, id)
    Signal:emit('input_' .. input_type, input.direction[id])
  end
}

local action_keymap = {
  -- p1 actions
  z      = 1,
  x      = 2,
  c      = 3,
  f8     = 4,
  escape = 5,
  -- p2 actions
  b      = 6,
  n      = 7,
  m      = 8,
  f9     = 9,
  p      = 10,
}

local direction_keymap = {
  -- p1 directions
  up    = 1,
  down  = 2,
  left  = 3,
  right = 4,
  -- p2 directions
  w     = 6,
  s     = 7,
  a     = 8,
  d     = 9,
}

local function check_held_directions ()
  -- check held directions
  for key, direction_id in pairs(direction_keymap) do
    local processed = {}
    if love.keyboard.isDown(key) then
      handle.direction('hold', direction_id)
      processed[direction_id] = true
    end
    if not processed[1] and not processed[2] and not processed[3] and not processed[4] then
      handle.direction('hold', 5)
    end
    if not processed[6] and not processed[7] and not processed[8] and not processed[9] then
      handle.direction('hold', 10)
    end
  end
end

local function check_held_actions ()
  -- check held actions
  for key, action_id in pairs(action_keymap) do
    if love.keyboard.isDown(key) then
      handle.action('hold', action_id)
    end
  end
end


function input.keypressed (key)
end

function input.keyreleased (key)
end

function input.set_action_key (key, action)
end

function input.set_direction_key (key, direction)
end

function input.load ()
  -- load from saved profile
end

function input.update ()
  check_held_directions()
  check_held_actions()
end

return input
