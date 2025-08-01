local EntityManager = require("ecsv2.entitymanager")
local Entity = require("ecsv2.entity")

local Systems = {}

--====================================================
-- Systems
--====================================================








Systems.RenderSystem = {
    update = function(dt)
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
