local gamera = require "libs/gamera"

Game = Object:extend();

function Game:init()
    _G.G = self;

    self:set_globals();
end

function Game:start_up()
    self.cam = gamera.new(0, 0, G.WORLD_WIDTH, G.WORLD_HEIGHT)

    self.grid = Grid()

    self.grid:generate()

    self.player = Player()
end

function Game:update(dt)
    self.grid:update(dt)

    G.DEBUG_VALUES["FPS"] = love.timer.getFPS()

    self.player:handleMovement(dt)
    self.cam:lookAt(self.player)
end

function Game:draw()
    self.cam:draw(function(l, t, w, h)
        self:draw_background(l, t, w, h);
        self.grid:draw();

        local drawOrder = { 
            G.I.NODE, 
            G.I.SPRITE, 
            -- G.I.BLOCK, 
            G.I.PLAYER
        }

        for _, instances in ipairs(drawOrder) do
            for _, v in pairs(instances) do
                v:draw()
            end
        end
    end)

    love.graphics.push()
        local index = 0
        for key, debug_value in pairs(G.DEBUG_VALUES) do
            love.graphics.print(key .. ": " .. debug_value, 10, 10 + 20 * index)
            index = index + 1
        end
    love.graphics.pop()
end

function Game:keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end
end

function Game:wheelmoved(dx, dy)
    local currentScale = self.cam:getScale();
    print(currentScale);
    if (dy > 0) and currentScale < G.CAMERA.MAX_ZOOM then
        -- zoom in
        self.cam:setScale(currentScale + G.CAMERA.ZOOM_STEP)
    elseif (dy < 0) and currentScale >= G.CAMERA.MIN_ZOOM then
        -- zoom out
        self.cam:setScale(currentScale - G.CAMERA.ZOOM_STEP)
    end
end

function Game:draw_background(l, t, w, h)
    love.graphics.push()
        love.graphics.setColor(0.1, 0, 0.1, 1)
        love.graphics.rectangle('fill', l, t, w, h)
        love.graphics.setColor(1, 1, 1, 1)
    love.graphics.pop()
end
