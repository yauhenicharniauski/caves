local gamera = require "libs/gamera"

Game = Object:extend();

function Game:init()
    _G.G = self;

    self:set_globals();
end

function Game:start_up()
    love.graphics.setDefaultFilter("nearest", "nearest") -- Prevent blurring

    self.cam = gamera.new(0, 0, 10000, 10000)

    Sprite({ x = 100, y = 100, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT_T)
    Sprite({ x = 200, y = 100, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT_R)
    Sprite({ x = 400, y = 100, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT_L)

    Sprite({ x = 100, y = 200, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT)
    Sprite({ x = 200, y = 200, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT_TR)
    Sprite({ x = 300, y = 200, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT_T)
    Sprite({ x = 400, y = 200, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT_TL)

    Sprite({ x = 100, y = 300, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT)
    Sprite({ x = 200, y = 300, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT)
    Sprite({ x = 300, y = 300, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT)
    Sprite({ x = 400, y = 300, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT)
end

function Game:update(dt)

end

function Game:draw()
    self.cam:draw(function(l, t, w, h)
        self:draw_background(l, t, w, h);

        for _, v in pairs(G.I.NODE) do
            v:draw();
        end
    
        for _, v in pairs(G.I.SPRITE) do
            v:draw();
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
        local dstep = key == "]" and 100 or -100;
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
    love.graphics.pop()
end
