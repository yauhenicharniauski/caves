VERSION = '0.0.0'

function Game:set_globals()
    self.VERSION = VERSION;

    -- Instances
    self.I = {
        NODE = {}
    }
end

G = Game();