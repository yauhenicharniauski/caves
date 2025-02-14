require "components/chunk"

---@class Grid
Grid = Node:extend()

function Grid:init()
    self.chunks = {}
end

function Grid:generate()
    -- 1 step / Chunks generation
    for row = 0, G.WORLD.CHUNK_COUNT_X - 1 do
        if not self.chunks[row] then
            self.chunks[row] = {}
        end
        
        for col = 0, G.WORLD.CHUNK_COUNT_Y - 1 do
            if not self.chunks[row][col] then
                self.chunks[row][col] = {}
            end

            self.chunks[row][col] = Chunk(
                row,
                col
            )
        end
    end
end

function Grid:update(dt)
    local visibleChunks = 0

    self:calculateVisibleChunk(function (chunk)
        chunk:update(dt)
        visibleChunks = visibleChunks + 1
    end)

    G.DEBUG_VALUES["VISIBLE_CHUNKS"] = visibleChunks
end

function Grid:draw()
    self:calculateVisibleChunk(function (chunk)
        chunk:draw()
    end)
end

function Grid:mousepressed(x, y, button)
    self:calculateVisibleChunk(function (chunk)
        chunk:mousepressed(x, y, button)
    end)
end

---Calculates visible chunks and applies a function to each one.
---@param func fun(chunk: Chunk)
function Grid:calculateVisibleChunk(func)
    if type(func) == "function" then
        local x1, y1, _, _, x3, y3, _, _ = G.cam:getVisibleCorners()

        local leftMostVisibleX = math.floor(x1 / G.WORLD.BLOCKS_PER_CHUNK_X / G.WORLD.BLOCK_PIXEL_SIZE)
        local rightMostVisibleX = math.floor(x3 / G.WORLD.BLOCKS_PER_CHUNK_X / G.WORLD.BLOCK_PIXEL_SIZE)
        local topMostVisibleY = math.floor(y1 / G.WORLD.BLOCKS_PER_CHUNK_Y / G.WORLD.BLOCK_PIXEL_SIZE)
        local bottomMostVisibleY = math.floor(y3 / G.WORLD.BLOCKS_PER_CHUNK_Y / G.WORLD.BLOCK_PIXEL_SIZE) 

        for x = leftMostVisibleX, rightMostVisibleX do
            if self.chunks and self.chunks[x] then
                for y = topMostVisibleY, bottomMostVisibleY do
                    if self.chunks[x][y] then
                        func(self.chunks[x][y])
                    end
                end
            end
        end
    end
end