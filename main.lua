_G.love = require("love")
local Vec = require("vector")
local Particle = require("particle")
local ParticleSystem = require("particlesystem")
local Utils = require("utils")

RADIUS = 32
W_WIDTH = 800
W_HEIGHT = 600

function is_even(n)
  return n > 5
end

function love.load()
  DEBUG = true
  -- Temp
  
  local numbers = {1,2,3,4,5,6,7,8,10}

  local even_number = Utils.filter(numbers, is_even)

  Utils.dump(even_number)
  
  -- particle = Particle.new(W_WIDTH/2, 20)
  -- system = ParticleSystem.new()
  
end

function love.mousepressed(x, y, button, istouch)
   if button == 1 then
    
  end
end

function love.keypressed(key, scancode, isrepeat)
   if key == "escape" then
      love.event.quit()
   end
end

function love.update(dt)
  -- particle:update(dt)
  -- system:add(Particle.new(W_WIDTH/2, 20))
  -- local gravity = Vec.createVector(0, 0.1)
  -- particle:applyForce(gravity)

  -- if (particle:isDead()) then
  --   particle = Particle.new(W_WIDTH/2, 20)
  --   print("Particle dead!")
  -- end

  -- system:update(dt)
end

function love.draw()
  -- Display FPS
  if DEBUG then
    love.graphics.setColor(1, 1, 1, 1) -- White
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
  end

  -- particle:draw()

  -- system:draw()

end