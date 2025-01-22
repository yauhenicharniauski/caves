Node = Object.extend();

-- Node represent any game object that needs to have some transform available in the game itself
-- Everything that you see in the game is a Node
--
-- For now nodes does not support children/container (don't see a reason to do this in this simple game)
-- All my needs can be handled with zIndex
--
---@param args {T: table}
-- T -> The transform ititializer, with keys of x|1, y|2, w|3, h|4, z|5
function Node:init(args)
    args = args or {}
    args.T = args.T or {}

    self.T = {
        x = args.T.x or args.T[1] or 0,
        y = args.T.y or args.T[2] or 0,
        w = args.T.w or args.T[3] or 0,
        h = args.T.h or args.T[4] or 0,
        z = args.T.z or args.T[5] or 0
    }

    self.states = {
        visible = true,
        click = { can = false, is = false }
    }
end