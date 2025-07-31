local Components = {}

---------------------------------------
-- Components
---------------------------------------
function Components.PositionComponent( x, y )
    local self = setmetatable({}, Components)
    self.x = x or 0
    self.y = y or 0
    return self
end

function Components.PhysicsComponent( ax, ay )
    local self = setmetatable({}, Components)
    self.acceleration = { x = ax or 0, y = ay or 0 }
    self.velocity = { x = 0, y = 0 }
    return self
end

function Components.PhysicsBoundaryComponent( w_width, w_height )
    local self = setmetatable({}, Components)
    self.w_width = w_width or 0
    self.w_height = w_height or 0
    return self
end

function Components.BoundaryComponent( w_width, w_height )
    local self = setmetatable({}, Components)
    self.w_width = w_width or 0
    self.w_height = w_height or 0
    return self
end

function Components.RenderableComponent( spriteName )
    local self = setmetatable({}, Components)
    self.sprite = spriteName or ""
    self.radius = love.math.random(5, 32)
    return self
end

function Components.ColorComponent( )
    local self = setmetatable({}, Components)
    local r = love.math.random()
    local g = love.math.random()
    local b = love.math.random()
    local a = love.math.random()
    self.color = {r, g, b, a}
    return self
end

function Components.CollideComponent( )
    local self = setmetatable({}, Components)
    self.isCollide = true
    return self
end

function Components.InputComponent(  )
    local self = setmetatable({}, Components)
    return self
end

function Components.EnemyIAComponent(  )
    local self = setmetatable({}, Components)
    return self
end

return Components