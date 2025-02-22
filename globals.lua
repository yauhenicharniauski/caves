_G.VERSION = '0.0.0'

function Game:set_globals()
    self.ENUMS = {
        AVAILABLE_LANGUAGES = {
            ENGLISH = "ENGLISH",  
        },
        BLOCKS = {
            DIRT = "DIRT"
        }
    }

    self.VERSION = VERSION
    self.SEED = 1234
    self.CURRENT_LANG = self.ENUMS.AVAILABLE_LANGUAGES.ENGLISH
    
    self.DEBUG = true
    self.DEBUG_FEATURES = {
        GRID = false, 
        PLAYER = true,
        FPS_COUNTER = true
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

    --------------------------
    --     BIT-MAP FONTS    --
    --------------------------
    
    self.FONT = {
        [self.ENUMS.AVAILABLE_LANGUAGES.ENGLISH] = {
            ATLAS = love.graphics.newImage("textures/fonts/en-uppercase.png"),
            LETTER_WIDTH = 7,
            LETTER_HEIGHT = 8,
            LETTERS = {
                ['A'] = { POS_X = 0, POS_Y = 0 },
                ['B'] = { POS_X = 1, POS_Y = 0 },
                ['C'] = { POS_X = 2, POS_Y = 0 },
                ['D'] = { POS_X = 3, POS_Y = 0 },
                ['E'] = { POS_X = 4, POS_Y = 0 },
                ['F'] = { POS_X = 5, POS_Y = 0 },
                ['G'] = { POS_X = 6, POS_Y = 0 },
                ['H'] = { POS_X = 0, POS_Y = 1 },
                ['I'] = { POS_X = 1, POS_Y = 1 },
                ['J'] = { POS_X = 2, POS_Y = 1 },
                ['K'] = { POS_X = 3, POS_Y = 1 },
                ['L'] = { POS_X = 4, POS_Y = 1 },
                ['M'] = { POS_X = 5, POS_Y = 1 },
                ['N'] = { POS_X = 6, POS_Y = 1 },
                ['O'] = { POS_X = 0, POS_Y = 2 },
                ['P'] = { POS_X = 1, POS_Y = 2 },
                ['Q'] = { POS_X = 2, POS_Y = 2 },
                ['R'] = { POS_X = 3, POS_Y = 2 },
                ['S'] = { POS_X = 4, POS_Y = 2 },
                ['T'] = { POS_X = 5, POS_Y = 2 },
                ['U'] = { POS_X = 6, POS_Y = 2 },
                ['V'] = { POS_X = 0, POS_Y = 3 },
                ['W'] = { POS_X = 1, POS_Y = 3 },
                ['X'] = { POS_X = 2, POS_Y = 3 },
                ['Y'] = { POS_X = 3, POS_Y = 3 },
                ['Z'] = { POS_X = 4, POS_Y = 3 },
            }
        }
    }

    -- Hello World
    -- H -> self.FONT[self.CURRENT_LANG].LETTERS
    --------------------------
    
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
        BLOCK_PIXEL_SIZE = 25
    }

    self.WORLD_WIDTH = self.WORLD.CHUNK_COUNT_X * self.WORLD.BLOCKS_PER_CHUNK_X * self.WORLD.BLOCK_PIXEL_SIZE
    self.WORLD_HEIGHT = self.WORLD.CHUNK_COUNT_Y * self.WORLD.BLOCKS_PER_CHUNK_Y * self.WORLD.BLOCK_PIXEL_SIZE

    -- dynamic debug values
    self.DEBUG_VALUES = {}
end

_G.G = Game();