---@class Sprite
Sprite = Node:extend();

-- Class for drawing sprites. For now this is just a Node, with an image above it.
--
---@param T: table
-- T -> The transform ititializer, with keys of x|1, y|2, w|3, h|4, r|5, z|6
---@param atlas_path: string
-- Atlas path, will be loaded to self.atlas on init
---@param sprite_size: table
-- Sprite position in atlas, with keys of w, h, p
---@param sprite_pos: table
-- Sprite position in atlas, with keys of row|1, column|2
function Sprite:init(T, atlas_path, sprite_size, sprite_pos)
    Node.init(self, { T = T });

    self.atlas = love.graphics.newImage(atlas_path)

    self.sprite = love.graphics.newQuad(
        sprite_size.w * sprite_pos[2] + sprite_size.p * sprite_pos[2],
        sprite_size.h * sprite_pos[1] + sprite_size.p * sprite_pos[1],
        sprite_size.w,
        sprite_size.h,
        self.atlas 
    );

    self.sprite_meta = {
        w = sprite_size.w,
        h = sprite_size.h,
    }

    if getmetatable(self) == Sprite then
        table.insert(G.I.SPRITE, self);
    end
end

function Sprite:draw()
    Node.draw(self)

    local sx = self.T.w / self.sprite_meta.w
    local sy = self.T.h / self.sprite_meta.h

    love.graphics.push()
    love.graphics.draw(self.atlas, self.sprite, self.T.x, self.T.y, 0, sx, sy)
    love.graphics.pop()
end

function Sprite:remove()
    for k, v in pairs(G.I.SPRITE) do
        if v == self then
            table.remove(G.I.SPRITE, v)
            break
        end
    end

    Node.remove(self);
end