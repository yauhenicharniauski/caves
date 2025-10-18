---@class Block
Block = Sprite:extend();

---@param xChunkRelative number
---@param yChunkRelative number
---@param block string -- block ID from BlockRegistry
---@param view integer
function Block:init(xChunkRelative, yChunkRelative, block, view)
    self.id = block
    self.settings = G.BlockRegistry:getBlock(block)

    love.math.setRandomSeed(xChunkRelative*73856093+yChunkRelative*19349663)
    self.randomViewIdx = math.random(1, #self.settings.texture.views[view])

    Sprite.init(
        self,
        { 
            x = xChunkRelative * G.WORLD.BLOCK_PIXEL_SIZE,
            y = yChunkRelative * G.WORLD.BLOCK_PIXEL_SIZE,
            w = G.WORLD.BLOCK_PIXEL_SIZE,
            h = G.WORLD.BLOCK_PIXEL_SIZE
        },
        self.settings.texture.atlas_loaded,
        self.settings.texture.sprite_size,
        self.settings.texture.views[view][self.randomViewIdx]
    )

    self.currentView = view
end

function Block:draw()
    Sprite.draw(self)
end

function Block:updateView(view)
    if self.settings.texture.views[view] then
        Sprite.updateSprite(self, self.settings.texture.views[view][self.randomViewIdx])
    end
end

function Block:nextView()
    local nextViewID = self.currentView + 1 > #self.settings.texture.views and 1 or self.currentView + 1
    self.currentView = nextViewID
    Sprite.updateSprite(self, self.settings.texture.views[nextViewID][self.randomViewIdx])
end

function Block:isSolid()
    return self.settings.isSolid or false
end