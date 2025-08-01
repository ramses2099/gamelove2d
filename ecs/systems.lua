local EntityManager = require("ecs.entitymanager")

local Systems = {}

---------------------------------------
-- Systems
---------------------------------------

Systems.PhysicsSystem = {
    update = function(dt)
        local entitesToMove = EntityManager.getEntitiesWith({"PositionComponent", "PhysicsComponent"})
        for _, entity in ipairs(entitesToMove) do
            local pos = EntityManager.getComponent(entity, "PositionComponent")
            local phy = EntityManager.getComponent(entity, "PhysicsComponent")

            -- velocity --
            phy.velocity.x = phy.velocity.x  + phy.acceleration.x  * dt 
            phy.velocity.y = phy.velocity.y  + phy.acceleration.y  * dt 
            -- position --
            pos.x = pos.x + phy.velocity.x * dt
            pos.y = pos.y + phy.velocity.y * dt

        end       
    end
}

Systems.PhysicsBoundarySystem = {
    update = function(dt)
        local entitesToMove = EntityManager.getEntitiesWith({"PositionComponent","PhysicsComponent","PhysicsBoundaryComponent", "RenderableComponent"})
        for _, entity in ipairs(entitesToMove) do
            local pos = EntityManager.getComponent(entity, "PositionComponent")
            local phy = EntityManager.getComponent(entity, "PhysicsComponent")
            local boun = EntityManager.getComponent(entity, "PhysicsBoundaryComponent")
            local ren = EntityManager.getComponent(entity, "RenderableComponent")

            if(pos.x - ren.radius < 0) then
                phy.velocity.x = phy.velocity.x  * -1
            elseif (pos.x + ren.radius > boun.w_width) then
                phy.velocity.x = phy.velocity.x  * -1
            end

            if (pos.y - ren.radius < 0) then
                phy.velocity.y = phy.velocity.y * -1
            elseif(pos.y + ren.radius > boun.w_height) then
               phy.velocity.y = phy.velocity.y * -1
            end            
        end       
    end
}

Systems.CollisionSystem = {
    distSq = function (pos1, pos2)
        local dx = pos2.x - pos1.x
        local dy = pos2.y - pos1.y
        return math.sqrt((dx * dx) + (dy * dy))        
    end,
    update = function(dt)
        local collisionCandidates = EntityManager.getEntitiesWith({"PositionComponent","PhysicsComponent","RenderableComponent", "CollideComponent"})
        local numCandidate = #collisionCandidates

        for i = 1, numCandidate, 1 do
            local ent1 = collisionCandidates[i]
            local pos1 = EntityManager.getComponent(ent1, "PositionComponent")
            local phy1 = EntityManager.getComponent(ent1, "PhysicsComponent")
            local ren1 = EntityManager.getComponent(ent1, "RenderableComponent")
            
            for j= i + 1, numCandidate, 1 do
              local ent2 = collisionCandidates[j]
              local pos2 = EntityManager.getComponent(ent2, "PositionComponent")
              local phy2 = EntityManager.getComponent(ent2, "PhysicsComponent")
              local ren2 = EntityManager.getComponent(ent2, "RenderableComponent")

              local dist = Systems.CollisionSystem.distSq(pos1, pos2)
              local radiiSum = ren1.radius + ren2.radius
              local isCollision = dist <= (radiiSum)

              if (isCollision == true) then
                phy1.velocity.x = phy1.velocity.x  * -1
                phy1.velocity.y = phy1.velocity.y * -1
                -- other
                phy2.velocity.x = phy2.velocity.x  * -1
                phy2.velocity.y = phy2.velocity.y * -1
              end
            end
        end
    end
}

Systems.InputSystem ={
    update = function(dt)
        local ent1 = EntityManager.getEntityWith("InputComponent")
        local phy1 = EntityManager.getComponent(ent1, "PhysicsComponent")
       
        if love.keyboard.isDown("left") then
            phy1.acceleration.x = phy1.acceleration.x * -1 
        end
        if love.keyboard.isDown("right") then 
            phy1.acceleration.x = phy1.acceleration.x * -1
        end
        if love.keyboard.isDown("up") then end
        if love.keyboard.isDown("down") then end

    end
}

Systems.RenderSystem = {
    update = function(dt)
        local entitesToMove = EntityManager.getEntitiesWith({"PositionComponent", "RenderableComponent","ColorComponent"})
        for _, entity in ipairs(entitesToMove) do
            local pos = EntityManager.getComponent(entity, "PositionComponent")
            local re = EntityManager.getComponent(entity, "RenderableComponent")
            local colr = EntityManager.getComponent(entity, "ColorComponent")

            love.graphics.setColor(colr.color)
            love.graphics.circle("fill", pos.x, pos.y, re.radius)
            love.graphics.setLineWidth(5)
            love.graphics.setColor(1, 1, 1, 1)   
            love.graphics.circle("line", pos.x, pos.y, re.radius)
        end       
    end
}

return Systems