---@class Cell
Cell = Node:extend();

function Cell:init(x, y, block)
    Node.init(self, { T = { x = x * G.WORLD.BLOCK_PIXEL_SIZE, y = y * G.WORLD.BLOCK_PIXEL_SIZE, w = G.WORLD.BLOCK_PIXEL_SIZE, h = G.WORLD.BLOCK_PIXEL_SIZE }})

    self.block = block and block or nil;
    self.states = {
        interactive = false
    }
end

function Cell:draw()
    Node.draw(self, { 1, 0, 0, 0.2 });

    if self.block then
        self.block:draw()
    end
end

function Cell:setBlock(block) 
    if self.block then
        self.block:remove()
    end

    self.block = block
end