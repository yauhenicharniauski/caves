require "engine/object"
require "engine/node"
require "engine/sprite"
require "components/block"
require "game"
require "globals"

function love.load()
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