_G.love = require("love")
local Vec = require("vector")
local Mover = require("mover")
local Shape = require("shape")

RADIUS = 32
W_WIDTH = 800
W_HEIGHT = 600

function CreateBox(n)
  local self = {}

  for i = 1, 10, 1 do
    local position = Vector.Utils.ramdon2D(32, 650)
    local w = math.random(16,32)
    local h = math.random(16,32)

    self[i] = Shape.RectangularShape.new(position.x, position.y, w, h)
  end
  return self
end

function DrawBox(arrayRectShape, color)
  local color = color or {1, 0, 0, 1}
  for i, box in ipairs(arrayRectShape) do
    love.graphics.setColor(color)
    love.graphics.rectangle("fill", box.position.x, box.position.y, box.dimension.width, box.dimension.height)
    love.graphics.setLineWidth(5)
    love.graphics.setColor(1, 1, 1, 1)   
    love.graphics.rectangle("line", box.position.x, box.position.y, box.dimension.width, box.dimension.height)
  end  
end

function UpdateBox(arrayRectShape, dt)
  local vel = Vector.Utils.ramdon2D(-2, 2)
  for _, box in ipairs(arrayRectShape) do
    -- vel.x = vel.x * dt
    -- vel.y = vel.y * dt
    box.position:add(vel)
    vel:mult(0)
  end
end

function love.load()
  DEBUG = true
  -- Temp
  ArrayRectShape1 = CreateBox(10)
  ArrayRectShape2 = CreateBox(10)

  m = Mover.new()

  
end

function love.mousepressed(x, y, button, istouch)
   if button == 1 then 
    -- TODO
  end
end

function love.keypressed(key, scancode, isrepeat)
   if key == "escape" then
      love.event.quit()
   end
end

function love.update(dt)
 m:update(dt)
 UpdateBox(ArrayRectShape1, dt)
 UpdateBox(ArrayRectShape2, dt)
end

function love.draw()
  -- Display FPS
  if DEBUG then
    love.graphics.setColor(1, 1, 1, 1) -- White
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
  end

  m:draw()

  DrawBox(ArrayRectShape1)
  DrawBox(ArrayRectShape2,{0,1,0,1})

end