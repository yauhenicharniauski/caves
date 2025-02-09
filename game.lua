local gamera = require "libs/gamera"

Game = Object:extend();

function Game:init()
    _G.G = self;

    self:set_globals();
end

function Game:start_up()
    love.graphics.setDefaultFilter("nearest", "nearest") -- Prevent blurring

    self.cam = gamera.new(0, 0, G.WORLD.WIDTH * G.WORLD.CHUNK_WIDTH * G.WORLD.BLOCK_SIZE, G.WORLD.HEIGHT * G.WORLD.CHUNK_HEIGHT * G.WORLD.BLOCK_SIZE)

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
        self.cam:setPosition(x, y - G.CAM.step);
    end

    if key == "a" then
        local x, y = self.cam:getPosition();
        self.cam:setPosition(x - G.CAM.step, y);
    end

    if key == "s" then
        local x, y = self.cam:getPosition();
        self.cam:setPosition(x, y + G.CAM.step);
    end

    if key == "d" then
        local x, y = self.cam:getPosition();
        self.cam:setPosition(x + G.CAM.step, y);
    end

    if key == "]" or key == "[" then
        local dstep = key == "]" and 75 or -75;
        print('CAM STEP WAS CHANGED: ', G.CAM.step + dstep);
        G.CAM.step = G.CAM.step + dstep;
    end
end

function Game:wheelmoved(dx, dy)
    local currentScale = self.cam:getScale();
    print(currentScale);
    if (dy > 0) then
        -- zoom in
        self.cam:setScale(currentScale + 0.1)
    else 
        -- zoom out
        self.cam:setScale(currentScale - 0.1)
    end
end

function Game:draw_background(l, t, w, h)
    love.graphics.push()
    love.graphics.setColor(0.3, 0.8, 0.8, 1)
    love.graphics.rectangle('fill', l, t, w, h)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.pop()
end
