_G.VERSION = '0.0.0'

function Game:set_globals()
    self.VERSION = VERSION
    self.DEBUG = true

    -- Instances
    self.I = {
        NODE = {},
        SPRITE = {},
        BLOCK = {}
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
        }
    }

    self.CAM = {
        step = 123
    }

    self.WORLD = {
        WIDTH = 100, -- blocks
        HEIGHT = 100, -- blocks
        BLOCK_SIZE = 50
    }
end

_G.G = Game();