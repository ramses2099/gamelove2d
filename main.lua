_G.love = require("love")
local Vec = require("vector")
local Particle = require("particle")


RADIUS = 32
W_WIDTH = 800
W_HEIGHT = 600

function love.load()
  DEBUG = true
  -- Temp
  particle = Particle.new(W_WIDTH/2, 20)


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
  particle:update(dt)

  local gravity = Vec.createVector(0, 0.1)
  particle:applyForce(gravity)

  if (particle:isDead()) then
    particle = Particle.new(W_WIDTH/2, 20)
    print("Particle dead!")
  end

end

function love.draw()
  -- Display FPS
  if DEBUG then
    love.graphics.setColor(1, 1, 1, 1) -- White
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
  end

  particle:draw()




end