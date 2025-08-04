local Vec = require("vector")

Particle = {}
Particle.__index = Particle

function Particle.new(x, y)
    local self = setmetatable({}, Particle)
    self.position = Vec.createVector(x, y)
    self.acceleration = Vec.createVector()

    local vx = math.random(-1, 1)
    local vy = math.random(-2, 0)

    self.velocity = Vec.createVector(vx, vy)
    self.radius = 8
    self.lifespan = 255
    self.alpha = 1
    return self
end

function Particle:isDead()
    return (self.lifespan < 0.0)
end

function Particle:applyForce(force)
    self.acceleration:add(force)
end

function Particle:update(dt)
    self.velocity:add(self.acceleration)
    self.position:add(self.velocity)
    self.lifespan = self.lifespan - 2.0
    self.acceleration:mult(0)
    self.alpha = self.alpha - 0.5 * dt 
end

function Particle:draw()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(r, g, b, self.alpha)
    love.graphics.circle("fill", self.position.x, self.position.y, self.radius)
end

return Particle