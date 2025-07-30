-- entity
Vector = {}
Vector.__index = Vector

function Vector.createVector(x, y)
    local self = setmetatable({}, Vector)
    self.x = x or 0
    self.y = y or 0
    return self
end

function Vector:add(v)
    self.x = self.x + v.x
    self.y = self.y + v.y    
end

function Vector:sub(v)
    self.x = self.x - v.x
    self.y = self.y - v.y    
end

function Vector:mult(n)
    self.x = self.x * n
    self.y = self.y * n    
end

function Vector:div(n)
    self.x = self.x / n
    self.y = self.y / n    
end

function Vector:mag()
    local x = self.x * self.x
    local y = self.y * self.y
    local m = x + y
    return math.sqrt(m)    
end

function Vector:normalize()
    local m = self:mag()
    if (m > 0) then
        self:div(m)
    end        
end

function Vector.ramdon2D()
    local x = love.math.random(32, 750)
    local y = love.math.random(32, 750)
    return Vector.createVector(x, y)
end

function Vector:copy()
    return Vector.createVector(self.x, self.y)    
end

return Vector