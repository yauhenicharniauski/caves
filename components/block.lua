---@class Block
Block = Sprite:extend();

function Block:init(x, y, block, view)
    Sprite.init(
        self,
        { 
            x = x,
            y = y,
            w = G.WORLD.BLOCK_PIXEL_SIZE,
            h = G.WORLD.BLOCK_PIXEL_SIZE
        },
        G.TEXTURES[block].ATLAS_LOADED,
        G.TEXTURES[block].SPRITE_SIZE,
        G.TEXTURES[block].VIEWS[view]
    )

    self.blockType = block;
end

function Block:draw()
    Sprite.draw(self)
end

function Block:updateView(view)
    if G.TEXTURES[self.blockType].VIEWS[view] then
        Sprite.updateSprite(self, G.TEXTURES[self.blockType].VIEWS[view])
    end
end