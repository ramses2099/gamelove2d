--==========================================
-- Game module
--==========================================
local Utils = require("utils")

local Game = {}
Game.__index = Game

function Game.newGame()
    local self = setmetatable({}, Game) 
    self.PIXEL_PER_METER = 64
    love.physics.setMeter(self.PIXEL_PER_METER)
    -- self.world = love.physics.newWorld(0,9.81*self.PIXEL_PER_METER)
    self.world = love.physics.newWorld(0,0)

    self.projectilesPool = {}
    self.numberOfProjectiles = 10

    -- player --
    self.player = Game.Player.newPlayer(self)

    -- create projectiles Pool --
    self:createProjectiles()

    return self    
end

function Game:createProjectiles()
    for i = 1, self.numberOfProjectiles, 1 do
        self.projectilesPool[i] = Game.Projectile.newProjectile(self.world, 0, 0)
    end
end

function Game:getProjectile()
    for i=1, #self.projectilesPool, 1 do
        if self.projectilesPool[i].free then
            return self.projectilesPool[i]
        end
    end
end

function Game:update(dt)
    -- player --
    self.player:keyinput()

    --#region PROJECTILE
    for i = 1, #self.projectilesPool, 1 do
        self.projectilesPool[i]:update(dt)        
    end
    --#endregion
end

function Game:draw()
    -- draw --
    self.player:draw()

    --#region PROJECTILE
    for i = 1, #self.projectilesPool, 1 do
        self.projectilesPool[i]:draw()
        
    end
    --#endregion
end

--==========================================
-- Player
--==========================================

Game.Player = {}
Game.Player.__index = Game.Player


function Game.Player.newPlayer(game)
    local self = setmetatable({}, Game.Player)
    self.tag = "Player"
    self.game = game
    self.width = 64
    self.height = 64
    self.x = (W_WIDTH * 0.5 - 64/2)
    self.y = W_HEIGHT- 64
    self.bodyType = "dynamic"
    self.density = 1
    self.body = love.physics.newBody(self.game.world, self.x, self.y, self.bodyType)
    self.shape = love.physics.newRectangleShape(self.width/2, self.height/2, self.width, self.height)
    self.fixture = love.physics.newFixture(self.body, self.shape, self.density)
    self.body:setFixedRotation(true)

    return self    
end

function Game.Player:update( dt )
    
end

function Game.Player:keyinput( dt )
    if love.keyboard.isDown("right") then
        self.body:applyForce(400,0)
    elseif love.keyboard.isDown("left") then
        self.body:applyForce(-400,0)
    elseif love.keyboard.isDown("space") then       
        self:shoot()
    end
end

function Game.Player:shoot()
    local projectile = self.game:getProjectile()
    
    if projectile then
        local x, y = self.body:getPosition()
        x = x + self.width * 0.5
        projectile:start(x, y)
    end
end

function Game.Player:draw()
  love.graphics.setColor(0.28, 0.63, 0.05)
  love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end

Game.Projectile = {}
Game.Projectile.__index = Game.Projectile

function Game.Projectile.newProjectile(world, x, y)
    local self = setmetatable({}, Game.Projectile)
    self.tag = "Projectile"
    self.free = true
    self.speed = 20
    self.width =  4
    self.height = 20
    self.bodyType = "dynamic"
    self.density =  1
    self.body = love.physics.newBody(world, x, y, self.bodyType)
    self.shape = love.physics.newRectangleShape(self.width/2, self.height/2, self.width, self.height)
    self.fixture = love.physics.newFixture(self.body, self.shape, self.density)
    self.body:setFixedRotation(true)
    
    return self    
end

function Game.Projectile:start(x, y)    
    x = x - self.width * 0.5
    self.body:setPosition(x, y)
    self.free = false
end

function Game.Projectile:reset()
    self.free = true
end

function Game.Projectile:update( dt )
    if self.free ~= true then
        self.body:applyForce(0, -self.speed)
        if (self.body:getY()< self.height) then
            self:reset()
        end             
    end
end

function Game.Projectile:draw()
   if self.free ~= true then
    love.graphics.setColor(0.28, 0.63, 0.05)
    love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
   end
end

Game.Enemy = {}
Game.Enemy.__index = Game.Enemy

function Game.Enemy.newEnemy(world, x, y, width, height, bodyType, density)
    local self = setmetatable({}, Game.Enemy)
    self.tag = "Enemy"
    self.width = width or 32
    self.height = height or 32
    self.bodyType = bodyType or "dynamic"
    self.density = density or 1
    self.body = love.physics.newBody(world, x, y, self.bodyType)
    self.shape = love.physics.newRectangleShape(self.width/2, self.height/2, self.width, self.height)
    self.fixture = love.physics.newFixture(self.body, self.shape, self.density)

    return self    
end

function Game.Enemy:update( dt )
    
end

function Game.Enemy:draw()
   
end


return Game