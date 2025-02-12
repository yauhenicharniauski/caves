---@class Cell
Cell = Node:extend();

function Cell:init(x, y, block)
    Node.init(self, { T = { 
                x = x, 
                y = y, 
                w = G.WORLD.BLOCK_PIXEL_SIZE, 
                h = G.WORLD.BLOCK_PIXEL_SIZE }})

    self.block = block and block or nil;
    self.states = {
        interactive = false
    }
end

function Cell:update(dt)
    -- all visible cells will check if they are in the player radius
    self.states.interactive = Utils.withinPlayerRadius(G.player.BUILD_ACTION_RADIUS, self)
end

function Cell:draw()
    if self.block then
        if self.states.interactive then love.graphics.setColor(1, 0, 0, 0.5) end

        self.block:draw()

        love.graphics.setColor(1, 1, 1, 1)
    end
end

function Cell:removeBlock()
    if self.block then
        self.block:remove()
    end

    self.block = nil
end

function Cell:setBlock(block) 
    self:removeBlock()

    self.block = block
end

function Cell:mousepressed(x, y, button)
    -- refactor next time, move func to utils
    local wx, wy = G.cam:toWorld(x, y)

    if wx > self.T.x and
        wx < self.T.x + self.T.w and
        wy > self.T.y and
        wy < self.T.y + self.T.h then

        if self.states.interactive then
            if button == 2 then
                local block = Block(self.T.x, self.T.y, G.ENUMS.BLOCKS.DIRT, 2)

                self:setBlock(block)
            end

            if button == 1 then
                self:removeBlock()
            end
        end
    end
end