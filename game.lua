--==========================================
-- Game module
--==========================================

local Game = {}
Game.__index = Game

function Game.newGame()
    local self = setmetatable({}, Game) 
    self.PIXEL_PER_METER = 100
    self.world = love.physics.newWorld(0,9.81*self.PIXEL_PER_METER)

    return self    
end

--==========================================
-- Player
--==========================================

Game.Player = {}
Game.Player.__index = Game.Player


function Game.Player.newPlayer(world, x, y)
    local self = setmetatable({}, Game.Player)
    self.w = 32
    self.h = 32
    self.body = love.physics.newBody(world, x, y,"dynamic")
    self.shape = love.physics.newRectangleShape(self.w/2, self.h/2, self.w, self.h)
    self.fixture = love.physics.newFixture(self.body, self.shape)

    return self    
end

Game.Projectile = {}
Game.Projectile.__index = Game.Projectile

function Game.newProjectile()
    local self = setmetatable({}, Game.Projectile)
    

    return self    
end

Game.Enemy = {}
Game.Enemy.__index = Game.Enemy


function Game.newEnemy()
    local self = setmetatable({}, Game.Enemy)
    return self    
end



return Game