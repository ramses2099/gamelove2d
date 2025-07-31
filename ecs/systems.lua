local EntityManager = require("ecs.entitymanager")

local Systems = {}

---------------------------------------
-- Systems
---------------------------------------

--#region Temp
Systems.MovementSystem = {
    update = function(dt)
        local entitesToMove = EntityManager.getEntitiesWith({"PositionComponent", "VelocityComponent"})
        for _, entity in ipairs(entitesToMove) do
            local pos = EntityManager.getComponent(entity, "PositionComponent")
            local vel = EntityManager.getComponent(entity, "VelocityComponent")

            pos.x = pos.x + vel.vx * dt
            pos.y = pos.y + vel.vy * dt
        end       
    end
}


Systems.BoundarySystem = {
    update = function(dt)
        local entitesToMove = EntityManager.getEntitiesWith({"PositionComponent","VelocityComponent","BoundaryComponent", "RenderableComponent"})
        for _, entity in ipairs(entitesToMove) do
            local pos = EntityManager.getComponent(entity, "PositionComponent")
            local vel = EntityManager.getComponent(entity, "VelocityComponent")
            local boun = EntityManager.getComponent(entity, "BoundaryComponent")
            local ren = EntityManager.getComponent(entity, "RenderableComponent")

            if(pos.x - ren.radius < 0) then
                vel.vx = vel.vx * -1
            elseif (pos.x + ren.radius > boun.w_width) then
                vel.vx = vel.vx * -1
            end

            if (pos.y - ren.radius < 0) then
                vel.vy = vel.vy * -1
            elseif(pos.y + ren.radius > boun.w_height) then
                vel.vy = vel.vy * -1
            end            
        end       
    end
}
--#endregion temp


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
        return (dx * dx) + (dy * dy)        
    end,
    update = function(dt)
        local entitesToMove = EntityManager.getEntitiesWith({"PositionComponent","PhysicsComponent","RenderableComponent", "CollideComponent"})
        for _, entity1 in ipairs(entitesToMove) do
            local pos1 = EntityManager.getComponent(entity1, "PositionComponent")
            local phy1 = EntityManager.getComponent(entity1, "PhysicsComponent")
            local ren1 = EntityManager.getComponent(entity1, "RenderableComponent")
            local collide1 = EntityManager.getComponent(entity1, "CollideComponent")
            
            for _, entity2 in ipairs(entitesToMove) do
                local pos2 = EntityManager.getComponent(entity2, "PositionComponent")
                local phy2 = EntityManager.getComponent(entity2, "PhysicsComponent")
                local ren2 = EntityManager.getComponent(entity2, "RenderableComponent")
                local collide2 = EntityManager.getComponent(entity2, "CollideComponent")

                -- Collide Validate --
                local dist = Systems.CollisionSystem.distSq(pos1, pos2)
                local radiiSum = ren1.radius + ren2.radius
                local isCollide = dist <= (radiiSum * radiiSum)

                if isCollide then
                    print(string.format("Collision detected between Entity %d and Entity %d!", entity1.id, entity2.id))

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