local Physics = {}
Physics.__index = Physics

function Physics.newRectangleShape(world, x, y, width, height, bodyType, density)
    local self = setmetatable({}, Physics)
    self.width = width or 32
    self.height = height or 32
    self.bodyType = bodyType or "dynamic"
    self.density = density or 1
    self.body = love.physics.newBody(world, x, y, self.bodyType)
    self.shape = love.physics.newRectangleShape(self.width/2, self.height/2, self.width, self.height)
    self.fixture = love.physics.newFixture(self.body, self.shape, self.density)
    return self
end

--[[
Static bodies do not move.
dynamic
Dynamic bodies collide with all bodies.
kinematic
Kinematic bodies only collide with dynamic bodies.
]]--


function Physics.newCircleShape(world, x, y, radius, bodyType, density)
    local self = setmetatable({}, Physics)
    self.radius = radius or 32
    self.bodyType = bodyType or "dynamic"
    self.density = density or 2
    self.body = love.physics.newBody(world, x, y, self.bodyType)
    self.shape = love.physics.newCircleShape(self.radius)
    self.fixture = love.physics.newFixture(self.body, self.shape, self.density)
    self.fixture:setRestitution(0.9)
    return self
end

--[[
    table vertices
    A list of vertices to construct the polygon, in the form of {x1, y1, x2, y2, x3, y3, ...}.
]]

function Physics.newPolygonShape(world, x, y, vertices, bodyType, density)
    local self = setmetatable({}, Physics)
    self.bodyType = bodyType or "dynamic"
    self.density = density or 2
    self.body = love.physics.newBody(world, x, y, self.bodyType)
    self.shape = love.physics.newPolygonShape(vertices)
    self.fixture = love.physics.newFixture(self.body, self.shape, self.density)
    return self
end







return Physics