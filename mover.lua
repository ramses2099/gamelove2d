local Vector = require("vector")

Mover = {}
Mover.__index = Mover

function Mover.new()
    local self = setmetatable({}, Mover)
    -- position --
    self.position = Vector.Utils.ramdon2D(32, 650)

    -- acceleration --
    self.acceleration = Vector.Utils.ramdon2D(-2, 2)
    
    -- velocity --
    self.velocity = Vector.createVector(0, 0)
    
    -- radius --
    self.radius = 32 -- love.math.random(16, 32)
    
    -- mass -- 
    self.mass = 10

    self.color = {love.math.random(0, 1),love.math.random(0, 1),love.math.random(0, 1), 1}
    self.w_height = 600
    self.w_width = 800

    return self
end

function Mover:applyForce(v)
    local f = v:copy()
    f:div(self.mass)
    self.acceleration:add(f)    
end

function Mover:draw()
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.position.x, self.position.y, self.radius)
    love.graphics.setLineWidth(5)
    love.graphics.setColor(1, 1, 1, 1)   
    love.graphics.circle("line", self.position.x, self.position.y, self.radius)
end

function Mover:update( dt )
    self.velocity:add(self.acceleration)
    self.position:add(self.velocity) 
    self:checkEdges()

    self.acceleration:mult(0)
end

function Mover:checkEdges()
    if(self.position.x - self.radius < 0) then
        self.velocity.x = self.velocity.x * -1
    elseif (self.position.x + self.radius > self.w_width) then
        self.velocity.x = self.velocity.x * -1
    end

    if (self.position.y - self.radius < 0) then
        self.velocity.y = self.velocity.y * -1
    elseif(self.position.y + self.radius > self.w_height) then
        self.velocity.y = self.velocity.y * -1
    end
end

return Mover