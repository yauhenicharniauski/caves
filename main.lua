require "engine.class"
require "utils"

require "engine/node"
require "engine/sprite"
require "scenes.scene"
require "components/block"
require "components/grid"
require "components/player"
require "game"
require "globals"

I18n = require("locales")
I18n.fallback = "en"
I18n.setLocale("en")

local font = love.graphics.newFont("assets/fonts/Tiny5-Regular.ttf", 16)

function love.load()
    love.graphics.setFont(font)
    love.window.setMode(1280, 720, { display = 1, fullscreen = false })
    
    G:start_up();
end

function love.update(dt)
    if G.DEBUG then
        require("libs/lurker").update()        
    end

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

function love.wheelmoved(dx, dy)
    G:wheelmoved(dx, dy)
end

function love.mousemoved( x, y, dx, dy, istouch)
    G:mousemoved(x, y, dx, dy, istouch)
end

-- -- -- -- -- -- -- -- -- --

function love.keypressed(key, scancode, isrepeat)
    G:keypressed(key, scancode, isrepeat)
 end