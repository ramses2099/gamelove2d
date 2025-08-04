local Vector = require("vector")

local Vehicle = {}
Vehicle.__index = Vehicle

function Vehicle.new(x, y)
    local self = setmetatable({}, Mover)
    -- physics --
    self.position = Vector.createVector(x, y)
    self.velocity = Vector.createVector(0, 0)
    self.acceleration = Vector.createVector(0, 0)
    self.maxspeed = 4
    self.maxforce = 2
    -- physics --
    self.color = {1,1,0,0}

    return self
end


function Vehicle:draw()
    love.graphics.setColor(self.color)
    love.graphics.circle("fill", self.position.x, self.position.y, self.radius)
    love.graphics.setLineWidth(5)
    love.graphics.setColor(1, 1, 1, 1)   
    love.graphics.circle("line", self.position.x, self.position.y, self.radius)
end

function Vehicle:update( dt )
    self.velocity:add(self.acceleration)
    self.position:add(self.velocity) 
    self:checkEdges()

    self.acceleration:mult(0)
end

function Vehicle:checkEdges()
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

return Vehicle