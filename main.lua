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
    love.window.setMode(1280, 720, { display = 3, fullscreen = false })
    
    G:start_up();
end

function love.update(dt)
    G:update(dt);
end

function love.draw()
    G:draw();
end

function love.wheelmoved( dx, dy )
    G:wheelmoved(dx, dy)
end

function love.keypressed(key, scancode, isrepeat)
    G:keypressed(key, scancode, isrepeat)
 end