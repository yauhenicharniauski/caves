_G.VERSION = '0.0.0'

function Game:set_globals()
    self.VERSION = VERSION
    
    self.DEBUG = true
    self.DEBUG_FEATURES = {
        GRID = false, -- danger, low fps
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

    self.CAMERA = {
        min_zoom = 0.6,
        max_zoom = 1.5,
        zoom_step = 0.1,
        step = 100
    }

    self.WORLD = {
        -- how many chunks will be loaded
        WIDTH = 20, 
        HEIGHT = 10,
        -- chunk width in blocks
        CHUNK_WIDTH = 110, 
        CHUNK_HEIGHT = 60,

        BLOCK_SIZE = 25
    }

    self.WORLD_WIDTH = self.WORLD.WIDTH * self.WORLD.CHUNK_WIDTH * self.WORLD.BLOCK_SIZE
    self.WORLD_HEIGHT = self.WORLD.HEIGHT * self.WORLD.CHUNK_HEIGHT * self.WORLD.BLOCK_SIZE
end

_G.G = Game();