local Vector = require("vector")
local Shape = require("shape")

Mover = {}
Mover.__index = Mover

function Mover.new()
    local self = setmetatable({}, Mover)
    
    -- mass -- 
    self.mass = math.random(1,4)
    
    -- radius --
    local radius = math.sqrt(self.mass) * 10
    
    -- position --
    local position = Vector.createVector(250, 32)
    self.shape = Shape.CircularShape.new(position.x, position.y, radius)
    
    -- acceleration --
    self.acceleration = Vector.createVector(0, 0)
    
    -- velocity --
    self.velocity = Vector.createVector(0, 0)
    

    self.color = {0.5, 0.5, 0.5}
    self.w_height = 600
    self.w_width = 800

    return self
end

function Mover:applyForce(force)
    local f = Vector.Utils.div(force, self.mass)
    self.acceleration:add(f)    
end

function Mover:friction()
    local diff = self.w_height - (self.shape.position.y + self.shape.radius)
    if (diff < 1) then
        local friction = self.velocity:copy()
        friction:normalize()
        friction:mult(-1)

        local mu = 0.1
        local normal = self.mass
        friction:setMag(mu * normal)

        self:applyForce(friction)
    end
end

function Mover:draw()
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.shape.position.x, self.shape.position.y, self.shape.radius)
    love.graphics.setLineWidth(5)
    love.graphics.setColor(1, 1, 1, 1)   
    love.graphics.circle("line", self.shape.position.x, self.shape.position.y, self.shape.radius)
end

function Mover:update( dt )
    self.velocity:add(self.acceleration)
    self.shape.position:add(self.velocity) 
    self:checkEdges()

    self.acceleration:set(0,0)
end

function Mover:checkEdges()
    if(self.shape.position.x - self.shape.radius < 0) then
        self.velocity.x = self.velocity.x * -1
    elseif (self.shape.position.x + self.shape.radius > self.w_width) then
        self.velocity.x = self.velocity.x * -1
    end

    if (self.shape.position.y - self.shape.radius < 0) then
        self.velocity.y = self.velocity.y * -1
    elseif(self.shape.position.y + self.shape.radius > self.w_height) then
        self.velocity.y = self.velocity.y * -1
    end
end

return Mover