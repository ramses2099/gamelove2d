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

function Components.VelocityComponent( vx, vy )
    local self = setmetatable({}, Components)
    self.vx = vx or 0
    self.vy = vy or 0
    return self
end

function Components.AccelerationComponent( ax, ay )
    local self = setmetatable({}, Components)
    self.ax = ax or 0
    self.ay = ay or 0
    return self
end

function Components.RenderableComponent( spriteName )
    local self = setmetatable({}, Components)
    self.sprite = spriteName or ""
    self.radius = 32
    self.color = {1,1,0,1}
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