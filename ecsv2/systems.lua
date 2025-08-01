local EntityManager = require("ecsv2.entitymanager")
local Entity = require("ecsv2.entity")

local Systems = {}

--====================================================
-- Systems
--====================================================

Systems.PhysicsBoundarySystem = {
    update = function(dt)
        local entitesToMove = EntityManager.getAllEntities()        
        for _, entity in ipairs(entitesToMove) do
            local allComponentsRequired = Entity.hasComponentRequired(entity, {"PositionComponent","PhysicsComponent","PhysicsBoundaryComponent", "RenderableComponent"})
            if allComponentsRequired then
                local pos = Entity.getComponent(entity, "PositionComponent")
                local phy = Entity.getComponent(entity, "PhysicsComponent")
                local boun = Entity.getComponent(entity, "PhysicsBoundaryComponent")
                local ren = Entity.getComponent(entity, "RenderableComponent")

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
    end
}

Systems.PhysicsSystem = {
    update = function(dt)        
        local entitesToMove = EntityManager.getAllEntities()
        for _, entity in ipairs(entitesToMove) do
            local allComponentsRequired = Entity.hasComponentRequired(entity, {"PositionComponent", "PhysicsComponent"})
            if allComponentsRequired then
                local pos = Entity.getComponent(entity, "PositionComponent")
                local phy = Entity.getComponent(entity, "PhysicsComponent")

                -- velocity --
                phy.velocity.x = phy.velocity.x  + phy.acceleration.x  * dt 
                phy.velocity.y = phy.velocity.y  + phy.acceleration.y  * dt 
                -- position --
                pos.x = pos.x + phy.velocity.x * dt
                pos.y = pos.y + phy.velocity.y * dt
            end
        end       
    end
}

Systems.RenderSystem = {
    update = function()
        local entitesToRender = EntityManager.getAllEntities()
        for _, entity in ipairs(entitesToRender) do
            local allComponentsRequired = Entity.hasComponentRequired(entity, {"PositionComponent", "RenderableComponent","ColorComponent"})
            if allComponentsRequired then
                local pos = Entity.getComponent(entity, "PositionComponent")
                local re = Entity.getComponent(entity, "RenderableComponent")
                local colr = Entity.getComponent(entity, "ColorComponent")

                love.graphics.setColor(colr.color)
                love.graphics.circle("fill", pos.x, pos.y, re.radius)
                love.graphics.setLineWidth(5)
                love.graphics.setColor(1, 1, 1, 1)   
                love.graphics.circle("line", pos.x, pos.y, re.radius)
            end
        end       
    end
}

return Systems
