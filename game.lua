Game = Object:extend();

function Game:init()
    _G.G = self;

    self:set_globals();
end

function Game:start_up()
    love.graphics.setDefaultFilter("nearest", "nearest") -- Prevent blurring

    Sprite({ x = 100, y = 100, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT_T)
    Sprite({ x = 200, y = 100, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT_T)
    Sprite({ x = 300, y = 100, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT_T)
    Sprite({ x = 400, y = 100, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT_T)

    Sprite({ x = 100, y = 200, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT)
    Sprite({ x = 200, y = 200, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT)
    Sprite({ x = 300, y = 200, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT)
    Sprite({ x = 400, y = 200, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT)

    Sprite({ x = 100, y = 300, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT)
    Sprite({ x = 200, y = 300, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT)
    Sprite({ x = 300, y = 300, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT)
    Sprite({ x = 400, y = 300, w = 100, h = 100}, G.TEXTURES.DIRT.ATLAS, G.TEXTURES.DIRT.SPRITE_SIZE, G.TEXTURES.DIRT.VIEWS.DIRT)

    print(#G.I.NODE)
end

function Game:update(dt)

end

function Game:draw()
    self:draw_background();

    for _, v in pairs(G.I.NODE) do
        v:draw();
    end

    for _, v in pairs(G.I.SPRITE) do
        v:draw();
    end
end

function Game:draw_background()
    local width, height = love.window.getDesktopDimensions()

    love.graphics.push()
    love.graphics.setColor(0, 0, 0.1, 1)
    love.graphics.rectangle('fill', 0, 0, width, height)
    love.graphics.pop()
end
