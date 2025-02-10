Utils = {}

function Utils.trunc(num)
    return num >= 0 and math.floor(num) or math.ceil(num)
end

function Utils.withinPlayerRadius(node, r)
    if G.player and node and node.T then
        local dx = (node.T.x + node.T.w / 2) - (G.player.T.x + G.player.T.w / 2);
        local dy = (node.T.y + node.T.h / 2) - (G.player.T.y + G.player.T.h / 2);

        return (dx * dx + dy * dy) <= r * r
    end
end