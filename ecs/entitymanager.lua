local EntityManager = {}
EntityManager._nextEntityId = 1
EntityManager._entities = {}

---------------------------------------
-- Entity Manager
---------------------------------------
function EntityManager.createEntity()
    local entityId = EntityManager._nextEntityId
    EntityManager._nextEntityId = EntityManager._nextEntityId + 1
    local entity = {
        id = entityId
    }
    EntityManager._entities[entity] = entity
    return entity
end

function EntityManager.addComponent( entity, componentType, componentData )
    assert(type(entity)=="table")
    entity[componentType] = componentData
end

function EntityManager.getComponent( entity, componentType )
    assert(type(entity)=="table")
    return entity[componentType] 
end

function EntityManager.hasComponent( entity, componentType )
    assert(type(entity)=="table")
    return entity[componentType] ~= nil
end

function EntityManager.removeComponent( entity, componentType )
    assert(type(entity)=="table")
    entity[componentType] = nil
end

function EntityManager.getEntitiesWith( componentTypes )
    local matchingEntities = {}
    for _, entity in pairs(EntityManager._entities) do
        local hasAllComponents = true
        for _, componentType in ipairs(componentTypes) do
            if not EntityManager.hasComponent(entity, componentType) then
                hasAllComponents = false
                break
            end            
        end
        if hasAllComponents then
            table.insert(matchingEntities, entity)
        end
    end
    return matchingEntities
end



return EntityManager