Game = Object:extend();

function Game:init()
    _G.G = self;

    self:set_globals();
end

function Game:start_up()
    Node({ T = { x = 100, y = 100, w = 100, h = 100 } });
end

function Game:update(dt)

end

function Game:draw()
    self:draw_background();

    for _, v in pairs(G.I.NODE) do
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
