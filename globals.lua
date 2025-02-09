_G.VERSION = '0.0.0'

function Game:set_globals()
    self.VERSION = VERSION
    
    self.DEBUG = true
    self.DEBUG_FEATURES = {
        GRID = true,
        PLAYER = true
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

    self.TEXTURES = {
        DIRT = {
            ATLAS = "textures/dirt/dirt.png",
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

    self.CAM = {
        step = 123
    }

    self.WORLD = {
        -- how many chunks will be loaded
        WIDTH = 5, 
        HEIGHT = 5,
        -- chunk width in blocks
        CHUNK_WIDTH = 10, 
        CHUNK_HEIGHT = 10,

        BLOCK_SIZE = 25
    }
end

_G.G = Game();