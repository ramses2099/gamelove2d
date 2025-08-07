_G.love = require("love")
local Game = require("game")
_G.W_WIDTH = 600
_G.W_HEIGHT = 800
_G.DEBUG = true

--https://www.youtube.com/watch?v=cuudnyDyWGE&list=WL&index=4&t=2320s
function love.load()
  game = Game.newGame()

end

function love.keypressed( key, scancode, isrepeat )
    if key == "escape" then
        love.event.quit()
    end
end

function love.update(dt)
  -- update physics
  game.world:update(dt)
  -- game update --
  game:update()
end

function love.draw()
   -- Display FPS
  if DEBUG then
    love.graphics.setColor(1, 1, 1, 1) -- White
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
  end
  -- draw graphics
  -- game draw --
  game:draw()
   
end