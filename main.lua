_G.love = require("love")
local EntityManager = require("ecsv2.entitymanager")
local Entity = require("ecsv2.entity")
local Components = require("ecsv2.components")
local Systems = require("ecsv2.systems")


RADIUS = 32
W_WIDTH = 800
W_HEIGHT = 600

function GenerateEntities( )
  for i = 1, 10, 1 do
    local entity = EntityManager.createEntity()
     -- position --
    local x = love.math.random(32, 590)
    local y = love.math.random(32, 590)
    -- Accelartion --
    local ax = love.math.random(5, 10)
    local ay = love.math.random(3, 10)

    Entity.addComponent(entity, "EnemyIAComponent", Components.EnemyIAComponent())
    Entity.addComponent(entity, "PositionComponent", Components.PositionComponent(x, y))
    Entity.addComponent(entity, "ColorComponent", Components.ColorComponent())
    Entity.addComponent(entity, "RenderableComponent", Components.RenderableComponent())
    Entity.addComponent(entity, "PhysicsComponent", Components.PhysicsComponent(ax, ay))
    Entity.addComponent(entity, "PhysicsBoundaryComponent", Components.PhysicsBoundaryComponent(W_WIDTH, W_HEIGHT))
    Entity.addComponent(entity, "CollideComponent", Components.CollideComponent())
  end
end

function love.load()
  DEBUG = true
  -- Temp
  GenerateEntities()

  entity01 = EntityManager.createEntity("Player")
  Entity.addComponent(entity01, "PositionComponent",{ x=10, y=10 })
  Entity.addComponent(entity01, "ColorComponent",{ r=10, g=10, b=1, a=1 })
   
  for _, ent in ipairs(EntityManager.getAllEntities()) do
    print(string.format("Entity Id %s", ent.entityId))
  end

  totalentity = EntityManager.countEntity()
  print(string.format("Total Entity  %s", totalentity))
  
  local entEnemy = EntityManager.getEntityWithTag("Enemy")
  print("total entity enemy %s", #entEnemy)

  local entPlayer = EntityManager.getEntityWithTag("Player")
  print("total entity player %s", #entPlayer)

  local ok = Entity.hasComponentRequired(entity01, {"PositionComponent","ColorComponent2"})
  if ok then
    print("tiene todos los componenets necesarios")
  else
    print("no tiene todos los componenets necesarios")
  end

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
  Systems.PhysicsSystem.update(dt)
end

function love.draw()
  -- Display FPS
  if DEBUG then
    love.graphics.setColor(1, 1, 1, 1) -- White
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
  end

  Systems.RenderSystem.update()

end