
-- boost lua 5.1 functionalities
require 'basic.tableutility'

-- global modules
Signal = require 'basic.signal'
Timer = require 'basic.timer'
Globals = require 'globals'
Input = require 'input'

-- global delta time
DELTA = 0

-- frame info
local frameunit = Globals.frameunit

-- locals
local gamestate = require 'gamestate'
local manager = require 'manager'
local framedelay = 0

function love.load ()
  -- guarantee randomness
  love.math.setRandomSeed( os.time() )
  math.random = love.math.random

  -- load input module
  Input.load()

  -- set window values
  love.window.setMode(Globals.width, Globals.height)

  -- set debug quit
  print("registering signals...")
  Signal:register('p1_press', function (action)
    if action == 'quit' then love.event.quit() end
  end)
  Signal:register('p2_press', function (action)
    if action == 'quit' then love.event.quit() end
  end)

  print('everything loaded')

  gamestate.load(require 'gamestates.fight')

  love.graphics.setBackgroundColor(255,255,255)
end

function love.update (dt)
  -- set global delta value
  DELTA = dt

  -- set fixed framerate
  framedelay = framedelay + dt
  while framedelay >= frameunit do
    framedelay = framedelay - frameunit
    -- update code below

    -- update input module
    Input.update()

    -- update gamestate
    gamestate.update()
    manager:update()
  end
end

function love.draw ()
  gamestate.draw()
  manager:draw()
end

function love.keypressed (key)
  -- check press input for action
  Input.keypressed(key)
end

function love.keyreleased (key)
  -- check release input for action
  Input.keyreleased(key)
end
