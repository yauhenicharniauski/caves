require "engine/object"
require "engine/node"
require "engine/sprite"
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