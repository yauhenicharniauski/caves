---@class Player
Player = Node:extend() -- should be Moveable or smth like this in future

function Player:init()
    Node.init(self, { 
        T = { 
            x = (G.WORLD_WIDTH) / 2, 
            y = (G.WORLD_HEIGHT) / 2, 
            w = 50, h = 100 
        } 
    })

    self.SPEED = 1000
    self.BUILD_ACTION_RADIUS = 10 * G.WORLD.BLOCK_PIXEL_SIZE

    self._localPos = { x = 0, y = 0 }

    if getmetatable(self) == Player then
        table.insert(G.I.PLAYER, self);
    end
end

function Player:draw()
    Node.draw(self, { 0.75, 0.25, 0.75, 1 }, 5);

    if G.DEBUG and G.DEBUG_FEATURES.PLAYER then
        love.graphics.print("[GLOBAL]: " .. Utils.trunc(self.T.x) .. " | " .. Utils.trunc(self.T.y), self.T.x, self.T.y + self.T.h + 10) 
        love.graphics.print("[LOCAL]: " .. self._localPos.x .. " | " .. self._localPos.y, self.T.x, self.T.y + self.T.h + 25) 
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
        local newPos = self.T.y - self.SPEED * dt
        if newPos > 0 then
            self.T.y = newPos         
        end
    end

    if love.keyboard.isDown('d') then
        local newPos = self.T.x + self.SPEED * dt
        if newPos < G.WORLD_WIDTH - self.T.w then
            self.T.x = newPos          
        end
    end

    if love.keyboard.isDown('a') then
        local newPos = self.T.x - self.SPEED * dt
        if newPos > 0 then            
            self.T.x = newPos
        end
    end

    if love.keyboard.isDown('s') then
        local newPos = self.T.y + self.SPEED * dt
        if newPos < G.WORLD_HEIGHT - self.T.h then
            self.T.y = newPos          
        end
    end

    self._localPos = {
        x = Utils.trunc(self.T.x / G.WORLD.BLOCK_PIXEL_SIZE),
        y = Utils.trunc(self.T.y / G.WORLD.BLOCK_PIXEL_SIZE)
    }
end