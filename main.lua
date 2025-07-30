_G.love = require("love")
local Vector = require("vector")
local Mover = require("mover")

radius = 32
w_height = 600
w_width = 800

function love.load()
  DEBUG = true
  -- #region temp
  position = Vector.createVector(100, 100)
  velocity = Vector.createVector(0.9, 0.5)
  mover = Mover.new()
  -- #endregion

end

function love.mousepressed(x, y, button, istouch)
   if button == 1 then 
    local force = Vector.createVector(0.5, 0)
    mover:applyForce(force)
   end
end

function love.update(dt)
  position:add(velocity)

  if(position.x - radius < 0) then
    velocity.x = velocity.x * -1
  elseif (position.x + radius > w_width) then
    velocity.x = velocity.x * -1
  end

  if (position.y - radius < 0) then
    --position.y = radius
    velocity.y = velocity.y * -1
  elseif(position.y + radius > w_height) then
    --position.y = w_height - radius
    velocity.y = velocity.y * -1
  end

  -- gravity force --
  local force = Vector.createVector(0, 0.5)
  mover:applyForce(force)

  mover:update(dt)

end

function love.draw()
  -- Display FPS
  if DEBUG then
    love.graphics.setColor(1, 1, 1, 1) -- White
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
  end

  --#region update
   love.graphics.setColor(1, 0, 0, 1)
   love.graphics.circle("fill", position.x, position.y, radius)
   love.graphics.setLineWidth(5)
   love.graphics.setColor(1, 1, 1, 1)   
   love.graphics.circle("line", position.x, position.y, radius)
   --#endregion

   mover:draw()

end