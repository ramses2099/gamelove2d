_G.love = require("love")
local Vec = require("vector")
local Mover = require("mover")


RADIUS = 32
W_WIDTH = 800
W_HEIGHT = 600

function love.load()
  DEBUG = true
  -- Temp

  m1 = Mover.new()
  
end

function love.mousepressed(x, y, button, istouch)
   if button == 1 then
    local wind = Vector.createVector(0.2, 0) 
    m1:applyForce(wind)
    
  end
end

function love.keypressed(key, scancode, isrepeat)
   if key == "escape" then
      love.event.quit()
   end
end

function love.update(dt)
 -- applay gravity force --
 local gravity = Vector.createVector(0, 0.1)
 local weight = Vector.Utils.mult(gravity, m1.mass)
 m1:applyForce(weight)
 m1:friction()
 -- applay gravity force --

 m1:update(dt)
 
end

function love.draw()
  -- Display FPS
  if DEBUG then
    love.graphics.setColor(1, 1, 1, 1) -- White
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
  end

  m1:draw()
  

end