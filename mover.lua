local Vector = require("vector")

Mover = {}
Mover.__index = Mover

function Mover.new()
    local self = setmetatable({}, Mover)
    -- position --
    local x = love.math.random(32, 590)
    local y = love.math.random(32, 590)
    -- velocity --
    local vx = love.math.random(-2, 2)
    local vy = love.math.random(-2, 2)
    -- radius --
    self.radius = love.math.random(5, 32)
    -- mass -- 
    self.mass = 10

    self.position = Vector.createVector(x, y)
    -- self.velocity = Vector.createVector(vx, vy)
    self.velocity = Vector.createVector(0, 0)
    self.acceleration = Vector.createVector(0, 0)

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