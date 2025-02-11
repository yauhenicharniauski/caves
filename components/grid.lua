require "components/chunk"

---@class Grid
Grid = Node:extend()

function Grid:init()
    self.chunks = {}
    self.visibleChunks = {}

    self.updateTime = 0.3
    self.currentUpdateTime = 0

    Node:init(self);
end

function Grid:generate()
    -- 1 step / Chunks generation
    for row = 1, G.WORLD.CHUNK_COUNT_X do
        if not self.chunks[row] then
            self.chunks[row] = {}
        end
        
        for col = 1, G.WORLD.CHUNK_COUNT_Y do
            if not self.chunks[row][col] then
                self.chunks[row][col] = {}
            end

            self.chunks[row][col] = Chunk(
                row - 1,
                col - 1
            )
        end
    end

    self.generated = true
end

function Grid:update(dt)
    self.currentUpdateTime = self.currentUpdateTime + dt

    if self.currentUpdateTime > self.updateTime then
        self.currentUpdateTime = 0
        local x, y = G.cam:getPosition()

        local chunkX = math.floor(x / (G.WORLD.BLOCKS_PER_CHUNK_X * G.WORLD.BLOCK_PIXEL_SIZE)) + 1
        local chunkY = math.floor(y / (G.WORLD.BLOCKS_PER_CHUNK_Y * G.WORLD.BLOCK_PIXEL_SIZE)) + 1

        local currentChunk = { x = chunkX, y = chunkY }

        if self.generated then     
            local chunk_tl  = { x = currentChunk.x - 1,    y = currentChunk.y - 1 }
            local chunk_t   = { x = currentChunk.x,        y = currentChunk.y - 1 }
            local chunk_tr  = { x = currentChunk.x + 1,    y = currentChunk.y - 1 }
            local chunk_l   = { x = currentChunk.x - 1,    y = currentChunk.y }
            local chunk_m   = { x = currentChunk.x,        y = currentChunk.y }
            local chunk_r   = { x = currentChunk.x + 1,    y = currentChunk.y }
            local chunk_bl  = { x = currentChunk.x - 1,    y = currentChunk.y + 1 }
            local chunk_b   = { x = currentChunk.x,        y = currentChunk.y + 1 }
            local chunk_br  = { x = currentChunk.x + 1,    y = currentChunk.y + 1 }

            local chunkCoords = { chunk_tl, chunk_t, chunk_tr, chunk_l, chunk_m, chunk_r, chunk_bl, chunk_b, chunk_br }

            self.visibleChunks = {}

            for _, coords in pairs(chunkCoords) do
                local chunk = (self.chunks[coords.x] and self.chunks[coords.x][coords.y]) or nil
                local x1, y1, _, _, x2, y2 = G.cam:getVisibleCorners()

                local delta = G.WORLD.BLOCK_PIXEL_SIZE

                if chunk and Utils.AABB(chunk, x1 - delta, y1 - delta, x2 + delta, y2 + delta) then
                    table.insert(self.visibleChunks, chunk)
                end
            end
        end
    end

    for _, chunk in pairs(self.visibleChunks) do
        chunk:update(dt)
    end

    G.DEBUG_VALUES["VISIBLE_CHUNKS"] = #self.visibleChunks
end

function Grid:draw()
    for _, chunk in pairs(self.visibleChunks) do
        chunk:draw()
    end
end

function Grid:mousepressed(x, y, button)
    for _, chunk in pairs(self.visibleChunks) do
        chunk:mousepressed(x, y, button)
    end
end