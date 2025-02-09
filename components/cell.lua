---@class Cell
Cell = Node:extend();

function Cell:init(x, y)
    Node.init(self, { T = { x = x * G.WORLD.BLOCK_SIZE, y = y * G.WORLD.BLOCK_SIZE, w = G.WORLD.BLOCK_SIZE, h = G.WORLD.BLOCK_SIZE }})

    self.block = nil;
    self.states = {
        interactive = false
    }
end

function Cell:draw()
    Node.draw(self, { 1, 0, 0, 0.2 });

    -- if self.block then
    --  self.block:draw()
    -- end
end

function Cell:setBlock(block) 
    self.block = block;
end