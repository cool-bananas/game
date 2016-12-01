
local iterate = require 'basic.iterate'

local physics = require 'basic.physics'

function physics.enqueue (body)
  if not physics.queue then
    physics.queue = {}
  end
  table.insert(physics.queue, body)
end

function physics.collide ()
  if not physics.queue then print("nothing to collide") return end
  for i, this_hitbox in ipairs(physics.queue) do
    for j, that_hitbox in iterate.other(physics.queue, i) do
      local this, that = physics.layer_collision(this_hitbox:get_collision_area(), that_hitbox:get_collision_area())
      if this then
        if physics.rectangle_collision(this_hitbox:get_collision_area(), that_hitbox:get_collision_area()) then
          Signal:emit("collide", this_hitbox, that_hitbox)
        end
      end
      if that then
        if physics.rectangle_collision(this_hitbox:get_collision_area(), that_hitbox:get_collision_area()) then
          Signal:emit("collide", that_hitbox:get_id(), this_hitbox:get_id())
        end
      end
    end
  end
  for i, body in ipairs(physics.queue) do
    physics.queue[i] = nil
  end
end

return physics
