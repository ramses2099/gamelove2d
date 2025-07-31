_G.love = require("love")
local EntityManager = require("ecs.entitymanager")
local Components = require("ecs.components")
local Systems = require("ecs.systems")

RADIUS = 32
W_WIDTH = 800
W_HEIGHT = 600

function GenerateEntities(n)
  for i = 1, n, 1 do
    local entity = EntityManager.createEntity()
     -- position --
    local x = love.math.random(32, 590)
    local y = love.math.random(32, 590)
    -- Accelartion --
    local ax = love.math.random(5, 10)
    local ay = love.math.random(3, 10)

    EntityManager.addComponent(entity, "PositionComponent", Components.PositionComponent(x, y))
    EntityManager.addComponent(entity, "ColorComponent", Components.ColorComponent())
    EntityManager.addComponent(entity, "RenderableComponent", Components.RenderableComponent())
    EntityManager.addComponent(entity, "PhysicsComponent", Components.PhysicsComponent(ax, ay))
    EntityManager.addComponent(entity, "PhysicsBoundaryComponent", Components.PhysicsBoundaryComponent(W_WIDTH, W_HEIGHT))
    EntityManager.addComponent(entity, "CollideComponent", Components.CollideComponent())
  end
end

function love.load()
  DEBUG = true
  -- Temp
  GenerateEntities(10)


end

function love.mousepressed(x, y, button, istouch)
   if button == 1 then 
    -- TODO
  end
end

function love.update(dt)
  Systems.PhysicsSystem.update(dt)
  Systems.CollisionSystem.update(dt)
  Systems.PhysicsBoundarySystem.update(dt)
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