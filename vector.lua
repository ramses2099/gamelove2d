--===============================================
-- Vector class for manage operation with vectors
--===============================================
Vector = {}
Vector.__index = Vector

function Vector.createVector(x, y)
    local self = setmetatable({}, Vector)
    self.x = x or 0
    self.y = y or 0
    return self
end

function Vector:set(x, y)
    self.x = x
    self.y = y    
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

function Vector:setMag(mag)
    local x, y = self.x, self.y
    local m = math.sqrt(x * x + y * y)
    if mag == 0 then
        return {x = 0, y = 0}
    end
    local scale = mag / m
    return {
        x = x * scale,
        y = y * scale
    }   
end

function Vector:normalize()
    local m = self:mag()
    if (m > 0) then
        self:div(m)
    end        
end

function Vector:limit(max)
    local m = self:mag()
    if m > max then
        self:normalize()
        self.x = self.x * self.max
        self.y = self.y * self.max
    end
    return self    
end

function Vector:dist(v1)
    local dx = v1.x - self.x
    local dy = v1.y - self.y
    return math.sqrt(dx * dx + dy * dy)    
end

function Vector:heading()
    return math.atan2(self.x, self.y)    
end

function Vector:copy()
    return Vector.createVector(self.x, self.y)    
end

function Vector:__tostring()
    return "(" .. self.x .. "," .. self.y .. ")"
end

--=====================================================
-- Vector.Utils sub module of Vector with static method
--=====================================================
Vector.Utils = {}
Vector.Utils.__index = Vector.Utils

function Vector.Utils.ramdon2D(min, max)
    local x = love.math.random(min, max)
    local y = love.math.random(min, max)
    return Vector.createVector(x, y)
end

function Vector.Utils.sub(v1, v2)
    local x = v1.x - v2.x
    local y = v1.y - v2.y
    return Vector.createVector(x, y)
end

function Vector.Utils.add(v1, v2)
    local x = v1.x + v2.x
    local y = v1.y + v2.y
    return Vector.createVector(x, y)
end

function Vector.Utils.mult(v1, n)
    local x = v1.x * n
    local y = v1.y * n
    return Vector.createVector(x, y)
end

function Vector.Utils.div(v1, n)
    local x = v1.x / n
    local y = v1.y / n
    return Vector.createVector(x, y)
end

function Vector.Utils.normalize(v1)
    local length = math.sqrt(v1.x * v1.x + v1.y * v1.y)
    if length == 0 then
        return Vector.createVector()
    end

    local x = v1.x / length
    local y = v1.y / length

    return Vector.createVector(x, y)
end

function Vector.Utils.mag(v1)
    local x = v1.x * v1.x
    local y = v1.y * v1.y
    local m = x + y

    return math.sqrt(m)
end

function Vector.Utils.dist(v1, v2)
    local dx = v2.x - v1.x
    local dy = v2.y - v1.y
    return math.sqrt(dx * dx + dy * dy)
end

return Vector