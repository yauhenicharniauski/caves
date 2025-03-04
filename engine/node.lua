---@class Node
Node = Object:extend();

-- Node represent any game object that needs to have some transform available in the game itself
-- Everything that you see in the game is a Node
--
-- For now nodes does not support children/container (don't see a reason to do this in this simple game)
-- All my needs can be handled with zIndex
--
---@param args {T: table}
-- T -> The transform ititializer, with keys of x|1, y|2, w|3, h|4, r|5
function Node:init(args)
    args = args or {}
    args.T = args.T or {}
    
    self.T = {
        x = args.T.x or args.T[1] or 0,
        y = args.T.y or args.T[2] or 0,
        w = args.T.w or args.T[3] or 0,
        h = args.T.h or args.T[4] or 0,
        r = args.T.r or args.T[5] or 0
    }

    self.T.xCenter = self.T.x + self.T.w / 2
    self.T.yCenter = self.T.y + self.T.h / 2
end

-- Used only for debugging
function Node:draw_boundingrect(debugColor, borderWidth)
    if G.DEBUG then
        local transform = self.T;

        local color = debugColor and debugColor or {1, 0, 0, 1}; -- red
        local width = borderWidth or 1;

        love.graphics.push();
            love.graphics.translate(transform.x + transform.w * 0.5, transform.y + transform.h * 0.5);
            love.graphics.rotate(transform.r);
            love.graphics.translate(-transform.w * 0.5, -transform.h * 0.5);
            love.graphics.setLineWidth(width);
            love.graphics.setColor(color);
            love.graphics.rectangle('line', 0, 0, transform.w, transform.h);

            love.graphics.setColor(1, 1, 1, 1);
        love.graphics.pop();
    end
end

function Node:draw(debugColor, debugBorderWidth)
    self:draw_boundingrect(debugColor, debugBorderWidth);
end