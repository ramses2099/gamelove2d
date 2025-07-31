_G.love = require("love")
local EntityManager = require("ecs.entitymanager")
local Components = require("ecs.components")
local Systems = require("ecs.systems")

radius = 32
w_height = 600
w_width = 800

function love.load()
  DEBUG = true
  entity01 = EntityManager.createEntity()
 
  EntityManager.addComponent(entity01, "PositionComponent", Components.PositionComponent(50, 50))
  EntityManager.addComponent(entity01, "RenderableComponent", Components.RenderableComponent())
  EntityManager.addComponent(entity01, "VelocityComponent", Components.VelocityComponent(1, 2))
   
end

function love.mousepressed(x, y, button, istouch)
   if button == 1 then 
    -- TODO
  end
end

function love.update(dt)
  
end

function love.draw()
  -- Display FPS
  if DEBUG then
    love.graphics.setColor(1, 1, 1, 1) -- White
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
  end
  
  -- System Render
  Systems.RenderSystem.update()


  
end