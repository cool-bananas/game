
local iterate = require 'basic.iterate'

local physics = require 'basic.physics'

local function verify_collision(f1, f2)
  for _,this_hitbox in ipairs(f1:get_current_frame()) do
    for _,that_hitbox in ipairs(f2:get_current_frame()) do
      local this, that = physics.layer_collision(this_hitbox, that_hitbox)
      if this then
        if physics.rectangle_collision(this_hitbox, that_hitbox) then
          Signal:emit("collide", f1:get_id(), f2:get_id())
        end
      end
      if that then
        if physics.rectangle_collision(this_hitbox, that_hitbox) then
          Signal:emit("collide", f1:get_id(), f2:get_id())
        end
      end
      if this or that then return end
    end
  end
end

function physics.enqueue (body)
  if not physics.queue then
    physics.queue = {}
  end
  table.insert(physics.queue, body)
end

function physics.collide ()
  if not physics.queue then print("nothing to collide") return end
  for i, this_frame in ipairs(physics.queue) do
    for j, that_frame in iterate.other(physics.queue, i) do
      verify_collision(this_frame, that_frame)
    end
  end
  for i, body in ipairs(physics.queue) do
    physics.queue[i] = nil
  end
end

return physics
