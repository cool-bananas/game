
--[[

GAMESTATES

How to use:
First of all, load this file in a variable.

> local GameStates = require "gamestate"

Create a table to use as a gamestate.

> local sample_gamestate = {}

Add functions to it. The functions available are:

sample_gamestate:init()
[ Executed when the state is loaded for the first time. ]

sample_gamestate:enter()
[ Executed when the state is loaded. ]

sample_gamestate:update()
[ Executed every logic update. ]

sample_gamestate:draw()
[ Executed every render update. ]

sample_gamestate:leave()
[ Executed when the state is closed or another state is loaded. ]

Then you can change states using the load() method.

> GameStates.load(sample_gamestate)

You don't need to close the state manually if
you're just going to load another right after.
Actually, please don't. It'll execute the leave()
method twice. You don't want that.

But if you don't want to load another state,
you can call the close() method manually.

]]


local gamestates = {}

local current = {}

function gamestates.load (gs)
  --[[ (table) -> void
  Receives a gamestate object.
  Initializes (if not initialized) and loads it. ]]

  -- if already loaded, do nothing
  if current == gs then return end

  -- close previous state
  gamestates.close()

  -- set current state
  current = gs

  -- initialize if necessary
  if not current.__initialized then
    if current.init then
      current:init()
      current.__initialized = true
    end
  end

  -- load gamestate
  if current.load then current:load() end
end

function gamestates.update ()
  --[[ () -> void
  Update gamestate logic. ]]

  if current.update then current:update() end
end

function gamestates.draw ()
  --[[ () -> void
  Call gamestate's rendering. ]]

  love.graphics.push()
  if current.draw then current:draw() end
  love.graphics.pop()
end

function gamestates.close ()
  --[[ () -> void
  Closes gamestate. ]]

  if current.leave then current:leave() end
end

function gamestates.current ()
  return current
end

return gamestates
