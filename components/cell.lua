---@class Cell
Cell = Node:extend();

---@param block Block
function Cell:init(xChunkRelative, yChunkRelative, block)
    Node.init(self, { T = { 
                x = xChunkRelative * G.WORLD.BLOCK_PIXEL_SIZE, 
                y = yChunkRelative * G.WORLD.BLOCK_PIXEL_SIZE, 
                w = G.WORLD.BLOCK_PIXEL_SIZE, 
                h = G.WORLD.BLOCK_PIXEL_SIZE }})

    self._chunk_x = xChunkRelative;
    self._chunk_y = yChunkRelative;
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
        -- if self.states.interactive then love.graphics.setColor(1, 0, 0, 0.5) end

        self.block:draw()

        -- love.graphics.setColor(1, 1, 1, 1)
    end
end

function Cell:removeBlock()
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
                if self.block then
                    self.block:nextView()
                else 
                    local block = Block(self._chunk_x, self._chunk_y, G.BlockRegistry.ENUM.DIRT, 2)
    
                    self:setBlock(block)
                end
            end

            if button == 1 then
                self:removeBlock()
            end
        end
    end
end

function Cell:calculateView()
    if self.block then

        local topCell = G.grid:getCell(self.T.xCenter, self.T.yCenter - G.WORLD.BLOCK_PIXEL_SIZE)

        if topCell and not topCell.block then
            self.block:updateView(1)
        end
    end
end