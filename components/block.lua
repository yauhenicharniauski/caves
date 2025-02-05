---@class Block
Block = Sprite:extend();

function Block:init(x, y, block)
    local texture = G.TEXTURES[block];

    if(texture) then
        Sprite.init(
            self, 
            { 
                x = x * G.WORLD.BLOCK_SIZE,
                y = y * G.WORLD.BLOCK_SIZE,
                w = G.WORLD.BLOCK_SIZE,
                h = G.WORLD.BLOCK_SIZE
            },
            texture.ATLAS,
            texture.SPRITE_SIZE,
            texture.VIEWS[2]
        )
    end

    if getmetatable(self) == Block then
        table.insert(G.I.BLOCK, self);
    end
end

function Block:draw()
    Sprite.draw(self)
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