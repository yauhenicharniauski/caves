require "components/chunk"

---@class Grid
Grid = Node:extend()

function Grid:init()
    self.chunks = {}
    self.currentChunk = { x = 0, y = 0}

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

function Grid:update()
    local chunkX = math.floor((G.player.T.x + G.player.T.w / 2) / (G.WORLD.BLOCKS_PER_CHUNK_X * G.WORLD.BLOCK_PIXEL_SIZE)) + 1
    local chunkY = math.floor((G.player.T.y + G.player.T.h / 2) / (G.WORLD.BLOCKS_PER_CHUNK_Y * G.WORLD.BLOCK_PIXEL_SIZE)) + 1

    self.currentChunk = { x = chunkX, y = chunkY }
end

function Grid:draw()
    if self.generated then     
        local chunk_tl  = { x = self.currentChunk.x - 1,    y = self.currentChunk.y - 1 }
        local chunk_t   = { x = self.currentChunk.x,        y = self.currentChunk.y - 1 }
        local chunk_tr  = { x = self.currentChunk.x + 1,    y = self.currentChunk.y - 1 }
        local chunk_l   = { x = self.currentChunk.x - 1,    y = self.currentChunk.y }
        local chunk_m   = { x = self.currentChunk.x,        y = self.currentChunk.y }
        local chunk_r   = { x = self.currentChunk.x + 1,    y = self.currentChunk.y }
        local chunk_bl  = { x = self.currentChunk.x - 1,    y = self.currentChunk.y + 1 }
        local chunk_b   = { x = self.currentChunk.x,        y = self.currentChunk.y + 1 }
        local chunk_br  = { x = self.currentChunk.x + 1,    y = self.currentChunk.y + 1 }

        local chunkCoords = { chunk_tl, chunk_t, chunk_tr, chunk_l, chunk_m, chunk_r, chunk_bl, chunk_b, chunk_br }

        -- refactor and use camera.visibleArea

        for _, coords in pairs(chunkCoords) do
            if self.chunks[coords.x] and self.chunks[coords.x][coords.y] then
                self.chunks[coords.x][coords.y]:draw()             
            end
        end
    end
end