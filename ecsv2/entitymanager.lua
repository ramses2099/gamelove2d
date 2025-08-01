local Entity = require("ecsv2.entity")
local EntityManager = {}
EntityManager.nextEntityId = 1
EntityManager.entities = {}

--==================================================
-- Entity Manager
--==================================================
function EntityManager.createEntity(tag)
    local entityId = EntityManager.nextEntityId
    EntityManager.nextEntityId = EntityManager.nextEntityId + 1
    
    local entity = Entity.createEntity(entityId, tag)
    EntityManager.entities[entityId] = entity
    
    return entity
end

function EntityManager.getAllEntities()
    return EntityManager.entities
end

function EntityManager.removeEntity(entityId)
    table.remove(EntityManager.entities, entityId)    
end

function EntityManager.countEntity()
    return #EntityManager.entities
end

function EntityManager.getEntityWithTag(tag)
    local matches = {}
    for _, v in ipairs(EntityManager.entities) do
        if v.tag == tag then
            table.insert(matches, v)
        end
    end
    return matches
end

return EntityManager