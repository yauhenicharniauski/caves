---@class Node
Node = Object:extend();

-- Node represent any game object that needs to have some transform available in the game itself
-- Everything that you see in the game is a Node
--
-- For now nodes does not support children/container (don't see a reason to do this in this simple game)
-- All my needs can be handled with zIndex
--
---@param args {T: table}
-- T -> The transform ititializer, with keys of x|1, y|2, w|3, h|4, r|5, z|6
function Node:init(args)
    args = args or {}
    args.T = args.T or {}

    self.T = {
        x = args.T.x or args.T[1] or 50,
        y = args.T.y or args.T[2] or 50,
        w = args.T.w or args.T[3] or 100,
        h = args.T.h or args.T[4] or 100,
        r = args.T.r or args.T[5] or 0,
        z = args.T.z or args.T[6] or 1
    }

    self.states = {
        visible = true,
        click = { can = false, is = false }
    }

    if getmetatable(self) == Node then
        table.insert(G.I.NODE, self);
    end
end

-- Used only for debugging
function Node:draw_boundingrect()
    if G.DEBUG then
        local transform = self.T

        love.graphics.push()
        love.graphics.translate(transform.x + transform.w * 0.5, transform.y + transform.h * 0.5);
        love.graphics.rotate(transform.r)
        love.graphics.translate(-transform.w * 0.5, -transform.h * 0.5);
        love.graphics.setColor(1, 0, 0, 1)
        love.graphics.rectangle('line', 0, 0, transform.w, transform.y)
        love.graphics.pop()
    end
end

function Node:draw()
    self:draw_boundingrect();
end

function Node:remove()
    for k, v in pairs(G.I.NODE) do
        if v == self then
            table.remove(G.I.NODE, v)
            break
        end
    end
end