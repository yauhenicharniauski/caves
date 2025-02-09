---@class Player
Player = Node:extend() -- should be Moveable or smth like this in future

function Player:init()
    -- add chunk draw depends on player pos
    Node.init(self, { 
        T = { 
            x = (G.WORLD_WIDTH) / 2, 
            y = (G.WORLD_HEIGHT) / 2, 
            w = 50, h = 100 
        } 
    })

    self.speed = 300

    if getmetatable(self) == Player then
        table.insert(G.I.PLAYER, self);
    end
end

function Player:draw()
    Node.draw(self, { 0.75, 0.25, 0.75, 1 }, 5);

    if G.DEBUG and G.DEBUG_FEATURES.PLAYER then
        love.graphics.print(self.T.x .. " | " .. self.T.y, self.T.x, self.T.y + self.T.h + 10) 
    end
end

function Player:remove()
    for k, v in pairs(G.I.PLAYER) do
        if v == self then
            table.remove(G.I.PLAYER, v)
            break
        end
    end

    Node.remove(self); -- extend class, do not forget to change
end

function Player:handleMovement(dt)
    if love.keyboard.isDown('w') then
        self.T.y = self.T.y - self.speed * dt
    end

    if love.keyboard.isDown('d') then
        self.T.x = self.T.x + self.speed * dt
    end

    if love.keyboard.isDown('a') then
        self.T.x = self.T.x - self.speed * dt
    end

    if love.keyboard.isDown('s') then
        self.T.y = self.T.y + self.speed * dt
    end
end