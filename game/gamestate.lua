
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

  if current.close then current:close() end
end

return gamestates
