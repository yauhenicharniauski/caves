Utils = {}

function Utils.trunc(num)
    return num >= 0 and math.floor(num) or math.ceil(num)
end

--- Is node or coords withing the player radius
--- @overload fun(r: number, node: Node)
--- @overload fun(r: number, x: number, y: number)
--- @param r number # radius
--- @param x Node | number # radius
--- @param y number # radius
function Utils.withinPlayerRadius(r, x, y)
    if G.player then
        local dx, dy = 0, 0
        
        local centerPlayerOrigin = {
            x = G.player.T.x + G.player.T.w / 2,
            y = G.player.T.y + G.player.T.h / 2
        }

        if type(x) == "table" then
            local node = x

            dx = (node.T.x + node.T.w / 2) - centerPlayerOrigin.x;
            dy = (node.T.y + node.T.h / 2) - centerPlayerOrigin.y;
        else
            dx = x - centerPlayerOrigin.x;
            dy = y - centerPlayerOrigin.y;
        end

        return (dx * dx + dy * dy) <= r * r
    end
end

--- Is target within node
---@overload fun(node: Node, target: Node)
---@overload fun(node: Node, x1: number, y1: number)
---@overload fun(node: Node, x1: number, y1: number, x2: number, y2: number)
---@param node Node # wrapper
---@param x1 Node # should be inside
function Utils.AABB(node, x1, y1, x2, y2)
    if node and node.T then

        if x1 and type(x1) == "table" then   
            return node.T.x < x1.T.x + x1.T.w and
                node.T.x + node.T.w > x1.T.x and
                node.T.y < x1.T.y + x1.T.h and
                node.T.y + node.T.h > x1.T.y
        end

        local x1 = x1;

        return (x2 and node.T.x < x2 or true) and
            node.T.x + node.T.w > x1 and
            (y2 and node.T.y < y2 or true) and
            node.T.y + node.T.h > y1
    end
end