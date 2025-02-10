---@class Block
Block = Sprite:extend();

function Block:init(x, y, block, view)
    self.texture = G.TEXTURES[block];

    if(self.texture) then
        Sprite.init(
            self, 
            { 
                x = x * G.WORLD.BLOCK_PIXEL_SIZE,
                y = y * G.WORLD.BLOCK_PIXEL_SIZE,
                w = G.WORLD.BLOCK_PIXEL_SIZE,
                h = G.WORLD.BLOCK_PIXEL_SIZE
            },
            self.texture.ATLAS_LOADED,
            self.texture.SPRITE_SIZE,
            self.texture.VIEWS[view]
        )
    end

    if getmetatable(self) == Block then
        table.insert(G.I.BLOCK, self);
    end
end

function Block:draw()
    Sprite.draw(self, { debug = false })
end

function Block:remove()
    for k, v in pairs(G.I.BLOCK) do
        if v == self then
            table.remove(G.I.BLOCK, v)
            break
        end
    end

    Sprite.remove(self);
end

function Block:updateView(view)
    if self.texture.VIEWS[view] then
        Sprite.updateSprite(self, self.texture.VIEWS[view])
    end
end