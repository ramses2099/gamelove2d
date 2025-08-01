local Entity = {}
--[[
    entityId number sequence,
    tag array list of tag {"Enemy","Player","Item", etc}
]]--
function Entity.createEntity(entityId, tag)
    local self = {
        entityId = entityId,
        tag = tag or "Enemy",
        components = {}
    }
    setmetatable(self, { __index = Entity })
    return self
end

function Entity.addComponent( entity, componentType, component )
    assert(type(entity)=="table","Entity is required")
    entity.components[componentType] = component
end

function Entity.getAllComponent( entity )
    assert(type(entity)=="table","Entity is required")
    return entity.components
end

function Entity.getComponent( entity, componentType )
    assert(type(entity)=="table","Entity is required")
    return entity.components[componentType]
end

function Entity.countComponent( entity )
    assert(type(entity)=="table","Entity is required")
    local table = entity.components
    local count = 0
    for _ in pairs(table) do
       count = count + 1 
    end
    return count
end

return Entity