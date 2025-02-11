require "utils"

require "engine/object"
require "engine/node"
require "engine/sprite"
require "components/block"
require "components/grid"
require "components/player"
require "game"
require "globals"

function love.load()
    love.window.setMode(1280, 720, { display = 1, fullscreen = false })
    
    G:start_up();
end

function love.update(dt)
    G:update(dt);
end

function love.draw()
    G:draw();
end

-- TODO: Refactor me
-- Create global event handler

function love.mousepressed(x, y, button, istouch)
    G:mousepressed(x, y, button)
 end

function love.wheelmoved( dx, dy )
    G:wheelmoved(dx, dy)
end

-- -- -- -- -- -- -- -- -- --

function love.keypressed(key, scancode, isrepeat)
    G:keypressed(key, scancode, isrepeat)
 end