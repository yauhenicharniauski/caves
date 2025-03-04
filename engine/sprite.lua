---@class Sprite
Sprite = Node:extend();

-- Class for drawing sprites. For now this is just a Node, with an image above it.
--
---@param T table
-- T -> The transform ititializer, with keys of x|1, y|2, w|3, h|4, r|5, z|6
---@param atlas string 
-- Preloaded atlas image
---@param sprite_size table
-- Sprite position in atlas, with keys of w, h, p
---@param sprite_pos table
-- Sprite position in atlas, with keys of row|1, column|2
function Sprite:init(T, atlas, sprite_size, sprite_pos)
    Node.init(self, { T = T });

    self.atlas = atlas

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
        p = sprite_size.p,
        sx = self.T.w / sprite_size.w,
        sy = self.T.h / sprite_size.h
    }
end

function Sprite:draw()
    love.graphics.draw(self.atlas, self.sprite, self.T.x, self.T.y, 0, self.sprite_meta.sx, self.sprite_meta.sy)
end

function Sprite:updateSprite(sprite_pos)
    self.sprite = love.graphics.newQuad(
        self.sprite_meta.w * sprite_pos[2] + self.sprite_meta.p * sprite_pos[2],
        self.sprite_meta.h * sprite_pos[1] + self.sprite_meta.p * sprite_pos[1],
        self.sprite_meta.w,
        self.sprite_meta.h,
        self.atlas 
    );
end