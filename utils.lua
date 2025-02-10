Utils = {}

function Utils.trunc(num)
    return num >= 0 and math.floor(num) or math.ceil(num)
end

--- refactor me pls ((((
function Utils.withinPlayerRadius(node, r)
    if G.player and node and node.T then
        local dx = (node.T.x + node.T.w / 2) - (G.player.T.x + G.player.T.w / 2);
        local dy = (node.T.y + node.T.h / 2) - (G.player.T.y + G.player.T.h / 2);

        return (dx * dx + dy * dy) <= r * r
    end
end

--- Is target within node
---@overload fun(node: Node, target: Node)
---@overload fun(node: Node, x1: number, y1: number, x2: number, y2: number)
---@param node Node # wrapper
---@param target Node # should be inside
function Utils.AABB(node, target, y1, x2, y2)
    if node and node.T then

        if target and type(target) == "table" then   
            return node.T.x < target.T.x + target.T.w and
                node.T.x + node.T.w > target.T.x and
                node.T.y < target.T.y + target.T.h and
                node.T.y + node.T.h > target.T.y
        end

        local x1 = target;

        return node.T.x < x2 and
            node.T.x + node.T.w > x1 and
            node.T.y < y2 and
            node.T.y + node.T.h > y1
    end
end