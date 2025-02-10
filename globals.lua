_G.VERSION = '0.0.0'

function Game:set_globals()
    self.VERSION = VERSION
    self.SEED = 1234
    
    self.DEBUG = true
    self.DEBUG_FEATURES = {
        GRID = false, 
        PLAYER = true,
        FPS_COUNTER = true
    }

    -- Instances
    self.I = {
        NODE = {},
        SPRITE = {},
        BLOCK = {},
        PLAYER = {},
    }

    self.ENUMS = {
        BLOCKS = {
            DIRT = "DIRT"
        }
    }

    --------------------------
    --      TEXTURES        --
    --------------------------
    love.graphics.setDefaultFilter("nearest", "nearest") -- Prevent blurring

    self.TEXTURES = {
        DIRT = {
            ATLAS = "textures/dirt/dirt.png",
            ATLAS_LOADED = nil,
            SPRITE_SIZE = {
                w = 8,
                h = 8,
                p = 1
            },
            VIEWS = {
                { 0, 0 },
                { 0, 1 },
                { 0, 2 },
                { 0, 3 },
                { 1, 0 },
                { 1, 1 },
                { 1, 2 },
                { 1, 3 }
            }
        },
        PLAYER = {
            ATLAS = "textures/player/player.png",
            ATLAS_LOADED = nil,
            SPRITE_SIZE = {
                w = 16,
                h = 32,
                p = 0
            },
            VIEWS = {
                {0, 0}
            }
        }
    }

    -- load textures
    for _, v in pairs(self.TEXTURES) do
        if not v.ATLAS_LOADED then
            v.ATLAS_LOADED = love.graphics.newImage(v.ATLAS)
        end
    end

    --------------------------

    self.CAMERA = {
        MIN_ZOOM = 0.6,
        MAX_ZOOM = 1.5,
        ZOOM_STEP = 0.2,
    }

    self.WORLD = {
        -- GENERATION
        CHUNK_COUNT_X = 3, 
        CHUNK_COUNT_Y = 3,
        BLOCKS_PER_CHUNK_X = 140,--140, 
        BLOCKS_PER_CHUNK_Y = 80,--80,
        BLOCK_PIXEL_SIZE = 25
    }

    self.DEBUG_VALUES = {}

    self.WORLD_WIDTH = self.WORLD.CHUNK_COUNT_X * self.WORLD.BLOCKS_PER_CHUNK_X * self.WORLD.BLOCK_PIXEL_SIZE
    self.WORLD_HEIGHT = self.WORLD.CHUNK_COUNT_Y * self.WORLD.BLOCKS_PER_CHUNK_Y * self.WORLD.BLOCK_PIXEL_SIZE
end

_G.G = Game();