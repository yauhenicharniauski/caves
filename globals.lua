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
                h = 8
            },
            VIEWS = {
                DIRT_T = 0,
                DIRT = 1
            }
        }
    }
end

_G.G = Game();