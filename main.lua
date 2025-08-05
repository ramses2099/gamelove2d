_G.love = require("love")
local Utils = require("utils")


RADIUS = 32
W_WIDTH = 800
W_HEIGHT = 600

--#region TEMP OBJECT

local player = { x=10, y=10, texture=love.graphics.newImage("assets/player.png")}
local crate = { x=200, y=100, texture=love.graphics.newImage("assets/create.png")}
local ball = { x=300, y=10, texture=love.graphics.newImage("assets/ball.png")}
local movingPlatform = { x=400, y=400, w=100, h=20}

local wall = {}

local speed = 200
local world = love.physics.newWorld(0,9.81)
--#endregion

function newWall( x, y, w, h )
  local self = {
    x = x,
    y = y,
    w = w,
    h = h,
    tag = "wall",
    body = love.physics.newBody(world, x, y,"static"),
    shape = love.physics.newRectangleShape(w/2, h/2, w, h)
  }
  wall.fixture = love.physics.newFixture(self.body, self.shape)
  table.insert(wall, self)
end



function love.load()
  DEBUG = true
  --#region TEMP OBJECT

  player.w, player.h = player.texture:getDimensions()
  crate.w, crate.h = crate.texture:getDimensions()
  ball.w, ball.h = ball.texture:getDimensions()

  player.body = love.physics.newBody(world,player.x,player.y,"dynamic")
  player.shape = love.physics.newRectangleShape(player.w/2, player.h/2, player.w, player.h)
  player.fixture = love.physics.newFixture(player.body, player.shape)
  player.body:setFixedRotation(true)

  crate.body = love.physics.newBody(world,crate.x,crate.y,"dynamic")
  crate.shape = love.physics.newRectangleShape(crate.w/2, crate.h/2, crate.w, crate.h)
  crate.fixture = love.physics.newFixture(crate.body, crate.shape)
  crate.body:setFixedRotation(true)

  ball.body = love.physics.newBody(world,ball.x,ball.y,"dynamic")
  ball.shape = love.physics.newRectangleShape(ball.w/2, ball.h/2, ball.w, ball.h)
  ball.fixture = love.physics.newFixture(ball.body, ball.shape)
 
  movingPlatform.body = love.physics.newBody(world,movingPlatform.x,movingPlatform.y,"kinematic")
  movingPlatform.shape = love.physics.newRectangleShape(movingPlatform.w/2, movingPlatform.h/2, movingPlatform.w, movingPlatform.h)
  movingPlatform.fixture = love.physics.newFixture(movingPlatform.body, movingPlatform.shape)

  local platformSpeed = 150
  movingPlatform.body:setLinearVelocity(platformSpeed, 0)
  
  -- bound wall
  newWall(0, W_HEIGHT-20, W_WIDTH, 20)
  newWall(0, 0, 20, W_HEIGHT)
  newWall(W_WIDTH-20,0,20,W_HEIGHT)

  -- block
  newWall(200, 450, 100, 100)
  newWall(600, 350, 100, 100)

  --#endregion


end

function love.mousepressed(x, y, button, istouch)
   if button == 1 then

  end
end

function love.keypressed(key, scancode, isrepeat)
   if key == "escape" then
      love.event.quit()
   end

  
end

function love.update(dt)
   --#region TEMP OBJECT
   world:update(dt)

   local dx, dy = 0, 0
   if love.keyboard.isDown('up') then
    dy = - speed 
   elseif love.keyboard.isDown('down') then
    dy = speed
   end

   if love.keyboard.isDown('left') then
    dx = - speed
   elseif love.keyboard.isDown('right') then
    dx = speed
   end

   player.body:setLinearVelocity(dx, dy)

   player.x, player.y = player.body:getPosition()
   crate.x, crate.y = crate.body:getPosition()
   ball.x, ball.y = ball.body:getPosition()

   movingPlatform.x, movingPlatform.y = movingPlatform.body:getPosition()
   if movingPlatform.x <= 20 or movingPlatform.x > W_WIDTH -movingPlatform.w -20 then
    local xvel, yvel = movingPlatform.body:getLinearVelocity()
    movingPlatform.body:setLinearVelocity(-xvel, 0)
   end
   --#endregion
end

function love.draw()
  -- Display FPS
  if DEBUG then
    love.graphics.setColor(1, 1, 1, 1) -- White
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
  end

  --#region TEMP
  love.graphics.draw(player.texture, player.x, player.y)
  love.graphics.draw(crate.texture, crate.x, crate.y)
  love.graphics.rectangle("line", movingPlatform.x, movingPlatform.y, movingPlatform.w, movingPlatform.h)

  local bx, by = ball.body:getPosition()
  love.graphics.circle("fill", bx, by, 4)
  love.graphics.draw(ball.texture, bx, by,0,1,1, ball.r, ball.r)

  for _, wa in ipairs(wall) do
    love.graphics.rectangle("line", wa.x, wa.y, wa.w, wa.h)
  end

  --#endregion

  
end