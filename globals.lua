_G.VERSION = '0.0.0'

function Game:set_globals()
    self.VERSION = VERSION
    self.DEBUG = true

    -- Instances
    self.I = {
        NODE = {},
        SPRITE = {}
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
                DIRT_T  = { 0, 0 },
                DIRT    = { 0, 1 },
                DIRT_L  = { 0, 2 },
                DIRT_R  = { 0, 3 },
                DIRT_TR = { 1, 0 },
                DIRT_TL = { 1, 1 },
                DIRT_BL = { 1, 2 },
                DIRT_BR = { 1, 3 },
            }
        }
    }

    self.CAM = {
        step = 100
    }
end

_G.G = Game();