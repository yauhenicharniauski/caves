_G.VERSION = '0.0.0'

function Game:set_globals()
    self.VERSION = VERSION
    self.DEBUG = true

    -- Instances
    self.I = {
        NODE = {}
    }
end

_G.G = Game();