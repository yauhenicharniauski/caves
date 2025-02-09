local gamera = require "libs/gamera"

Game = Object:extend();

function Game:init()
    _G.G = self;

    self:set_globals();
end

function Game:start_up()
    love.graphics.setDefaultFilter("nearest", "nearest") -- Prevent blurring

    self.cam = gamera.new(0, 0, G.WORLD_WIDTH, G.WORLD_HEIGHT)

    self.grid = Grid()

    self.grid:generate()

    self.player = Player()
    -- Block(3, 8, G.ENUMS.BLOCKS.DIRT, 1)
    -- Sprite({ x = 100, y = 100, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, 1)
end

function Game:update(dt)
    self.grid:update()

    self.player:handleMovement(dt)
    self.cam:lookAt(self.player)
end

function Game:draw()
    self.cam:draw(function(l, t, w, h)
        self:draw_background(l, t, w, h);
        self.grid:draw();

        for _, instances in pairs(G.I) do
            for _, v in pairs(instances) do
                v:draw()
            end
        end
    end)
end

function Game:keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end

    if key == "w" then
        local x, y = self.cam:getPosition();
        self.cam:setPosition(x, y - G.CAMERA.step);
    end

    if key == "a" then
        local x, y = self.cam:getPosition();
        self.cam:setPosition(x - G.CAMERA.step, y);
    end

    if key == "s" then
        local x, y = self.cam:getPosition();
        self.cam:setPosition(x, y + G.CAMERA.step);
    end

    if key == "d" then
        local x, y = self.cam:getPosition();
        self.cam:setPosition(x + G.CAMERA.step, y);
    end

    if key == "]" or key == "[" then
        local dstep = key == "]" and 75 or -75;
        print('CAM STEP WAS CHANGED: ', G.CAMERA.step + dstep);
        G.CAMERA.step = G.CAMERA.step + dstep;
    end
end

function Game:wheelmoved(dx, dy)
    local currentScale = self.cam:getScale();
    print(currentScale);
    if (dy > 0) and currentScale < G.CAMERA.max_zoom then
        -- zoom in
        self.cam:setScale(currentScale + G.CAMERA.zoom_step)
    elseif (dy < 0) and currentScale >= G.CAMERA.min_zoom then
        -- zoom out
        self.cam:setScale(currentScale - G.CAMERA.zoom_step)
    end
end

function Game:draw_background(l, t, w, h)
    love.graphics.push()
        love.graphics.setColor(0.1, 0, 0.1, 1)
        love.graphics.rectangle('fill', l, t, w, h)
        love.graphics.setColor(1, 1, 1, 1)
    love.graphics.pop()
end
