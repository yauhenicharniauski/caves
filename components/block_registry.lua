---@class BlockTextureView
---@field [1] integer  -- atlas X coord
---@field [2] integer  -- atlas Y coord

---@class BlockSpriteSize
---@field w number
---@field h number
---@field p number  -- padding

---@class BlockTextureSetting
---@field atlas string
---@field atlas_loaded love.Image | nil
---@field sprite_size BlockSpriteSize
---@field views BlockTextureView[]

---@class BlockSettings
---@field isSolid boolean
---@field texture BlockTextureSetting

---@class BlockRegistry
---@field SETTINGS BlockSettings[]
BlockRegistry = class();

BlockRegistry.ENUM = {
    DIRT = "DIRT"
}

function BlockRegistry:init()
    self.SETTINGS = {}
end

---@param name string 
---@param settings BlockSettings 
function BlockRegistry:register(name, settings)
    self.SETTINGS[name] = settings
end

---@return BlockSettings | nil
function BlockRegistry:getBlock(name)
    return self.SETTINGS[name] or nil
end