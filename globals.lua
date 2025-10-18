_G.VERSION = '0.0.0'

function Game:set_globals()
    self.ENUMS = {
        BLOCKS = {
            DIRT = "DIRT"
        }
    }

    self.VERSION = VERSION
    self.SEED = 1234
    
    self.DEBUG = true -- enables hot reload when running
    -- Debug info table (F3)
    self.DEBUG_F3_ENABLED = false
    self.DEBUG_F3_ENUM = {
        FPS = "fps",
        TIME = "time",
        DRAW_CALLS = "draw_calls",
        VISIBLE_CHUNKS = "visible_chunks",
        DRAW_CALLS_BATCHED = "draw_calls_batched",
        IMAGES_LOADED = "images_loaded",
        TEXTURE_MEM_USAGE = "texture_mem_usage",
        PLAYER_POS = "player_pos",
        SKIP_LINE = "-"
    }
    self.DEBUG_F3_TABLE_ORDER = {
        self.DEBUG_F3_ENUM.FPS,
        self.DEBUG_F3_ENUM.TIME,
        self.DEBUG_F3_ENUM.PLAYER_POS,
        self.DEBUG_F3_ENUM.SKIP_LINE,

        self.DEBUG_F3_ENUM.DRAW_CALLS,
        self.DEBUG_F3_ENUM.DRAW_CALLS_BATCHED,
        self.DEBUG_F3_ENUM.SKIP_LINE,

        self.DEBUG_F3_ENUM.VISIBLE_CHUNKS,
        self.DEBUG_F3_ENUM.SKIP_LINE,

        self.DEBUG_F3_ENUM.IMAGES_LOADED,
        self.DEBUG_F3_ENUM.TEXTURE_MEM_USAGE,
    }
    self.DEBUG_F3_TABLE = {}

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
                { 0, 0 }
            }
        }
    }

    -- load textures
    for _, v in pairs(self.TEXTURES) do
        if not v.ATLAS_LOADED then
            v.ATLAS_LOADED = love.graphics.newImage(v.ATLAS)
        end
    end
    
    self.CURSORS = {
        REGULAR = love.mouse.getSystemCursor("crosshair"),
        POINTER = love.mouse.getSystemCursor("hand")
    }

    self.CAMERA = {
        VIRTUAL_WIDTH = 1920,
        VIRTUAL_HEIGHT = 1080,
        ZOOM_DELTA = 0.5,
        ZOOM_STEP = 0.1,
        SCALE_FACTOR = nil
    }

    self.WORLD = {
        -- GENERATION
        CHUNK_COUNT_X = 3, 
        CHUNK_COUNT_Y = 3,
        BLOCKS_PER_CHUNK_X = 250,--140, 
        BLOCKS_PER_CHUNK_Y = 150,--80,
        BLOCK_PIXEL_SIZE = 25,
        -- summer time
        DAY_LENGTH = 180, -- 3 minutes
        DAY_START = 0.208, -- 5 / 24 hours
        NIGHT_START = 0.833, -- 20 / 24 hours
    }

    self.WORLD_WIDTH = self.WORLD.CHUNK_COUNT_X * self.WORLD.BLOCKS_PER_CHUNK_X * self.WORLD.BLOCK_PIXEL_SIZE
    self.WORLD_HEIGHT = self.WORLD.CHUNK_COUNT_Y * self.WORLD.BLOCKS_PER_CHUNK_Y * self.WORLD.BLOCK_PIXEL_SIZE
end

_G.G = Game();