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


  -- position --
  angle = 0 
  -- velocity --
  angleVelocity = 0
  -- acceleration --
  angleAcceleration = 0.0001;

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
 m1:update(dt)
end

function love.draw()
  -- Display FPS
  if DEBUG then
    love.graphics.setColor(1, 1, 1, 1) -- White
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
  end

  m1:draw()

  --[[
  love.graphics.translate(W_WIDTH/2, W_HEIGHT/2)
  -- rotation
  love.graphics.rotate(angle)
  love.graphics.line(-60, 0, 60, 0)

  love.graphics.setColor(1, 1, 1, 1) -- White
  love.graphics.circle("line", 60,0,16)
  love.graphics.setColor(0.5,0.5,0.5)
  love.graphics.circle("fill", 60,0,16)

  love.graphics.setColor(1, 1, 1, 1) -- White
  love.graphics.circle("line", -60,0,16)
  love.graphics.setColor(0.5,0.5,0.5)
  love.graphics.circle("fill", -60,0,16)
  
  angleVelocity = angleVelocity + angleAcceleration
  angle = angle + angleVelocity
 ]]


end