_G.love = require("love")
local EntityManager = require("ecsv2.entitymanager")
local Entity = require("ecsv2.entity")

RADIUS = 32
W_WIDTH = 800
W_HEIGHT = 600

function generateEntities( )
  for i = 1, 10, 1 do
    local entity = EntityManager.createEntity()
    Entity.addComponent(entity, "PositionComponent",{ x=1 + i, y=10 + i })
    Entity.addComponent(entity, "ColorComponent",{ r=10, g=10, b=1, a=1 }) 
    Entity.addComponent(entity, "RenderableComponent", { shape = "rect"})
    Entity.addComponent(entity, "PhysicsComponent", { vx = 15, vy = 35})
    Entity.addComponent(entity, "PhysicsBoundaryComponent", { w = 255, h = 333})
    Entity.addComponent(entity, "CollideComponent", {isCollide = true})
  end
end

function love.load()
  DEBUG = true
  -- Temp
  generateEntities()

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
  
end

function love.draw()
  -- Display FPS
  if DEBUG then
    love.graphics.setColor(1, 1, 1, 1) -- White
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
  end


end