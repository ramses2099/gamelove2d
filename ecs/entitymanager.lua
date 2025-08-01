local EntityManager = {}
EntityManager._nextEntityId = 1
EntityManager._entities = {}

local Entity = {}
Entity.__index = Entity

function Entity.new(id)
    local self = setmetatable({}, Entity)
    self.id = id
    self.components = {}
    return self  
end

---------------------------------------
-- Entity Manager
---------------------------------------
function EntityManager.createEntity()
    local entityId = EntityManager._nextEntityId
    EntityManager._nextEntityId = EntityManager._nextEntityId + 1
    local entity = Entity.new(entityId)
    EntityManager._entities[entityId] = entity
    return entity
end

function EntityManager.addComponent( entity, componentType, componentData )
    assert(type(entity)=="table")
    entity.components[componentType] = componentData
end

function EntityManager.getComponent( entity, componentType )
    assert(type(entity)=="table")
    return entity.components[componentType] 
end

function EntityManager.hasComponent( entity, componentType )
    assert(type(entity)=="table")
    for key, component in pairs(entity.components) do
        if key == componentType then
            return true
        end
    end
   return false
end

function EntityManager.removeComponent( entity, componentType )
    assert(type(entity)=="table")
    entity.components[componentType] = nil
end

function EntityManager.getEntitiesWith(componentTypes )
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

function EntityManager.getEntityWith( componentType )
    local entity = nil
    for _, ent in pairs(EntityManager._entities) do
        if EntityManager.hasComponent(ent, componentType) then
            return ent
        end            
    end
    return entity
end

return EntityManager
