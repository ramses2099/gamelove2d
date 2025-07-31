local EntityManager = require("ecs.entitymanager")

local Systems = {}

---------------------------------------
-- Systems
---------------------------------------

Systems.MovementSystem = {
    update = function(dt)
        local entitesToMove = EntityManager.getEntitiesWith({"PositionComponent", "VelocityComponent"})
        for _, entity in ipairs(entitesToMove) do
            local pos = EntityManager.getComponent(entity, "PositionComponent")
            local vel = EntityManager.getComponent(entity, "VelocityComponent")

            pos.x = pos.x + vel.x * dt
            pos.y = pos.y + vel.y * dt
        end       
    end
}

Systems.RenderSystem = {
    update = function(dt)
        local entitesToMove = EntityManager.getEntitiesWith({"PositionComponent", "RenderableComponent"})
        for _, entity in ipairs(entitesToMove) do
            local pos = EntityManager.getComponent(entity, "PositionComponent")
            local re = EntityManager.getComponent(entity, "RenderableComponent")

            love.graphics.setColor(re.color)
            love.graphics.circle("fill", pos.x, pos.y, re.radius)
            love.graphics.setLineWidth(5)
            love.graphics.setColor(1, 1, 1, 1)   
            love.graphics.circle("line", pos.x, pos.y, re.radius)
        end       
    end
}

return Systems