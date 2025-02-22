---@class Text
Text = Node:extend()

function Text:init(text, x, y)
    Node.init(self, { T = { x = x, y = y }})
end