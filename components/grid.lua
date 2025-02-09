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
    for row = 1, G.WORLD.WIDTH do
        if not self.chunks[row] then
            self.chunks[row] = {}
        end
        
        for col = 1, G.WORLD.HEIGHT do
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
    local chunkX = math.floor((G.player.T.x + G.player.T.w / 2) / (G.WORLD.CHUNK_WIDTH * G.WORLD.BLOCK_SIZE)) + 1
    local chunkY = math.floor((G.player.T.y + G.player.T.h / 2) / (G.WORLD.CHUNK_HEIGHT * G.WORLD.BLOCK_SIZE)) + 1

    self.currentChunk = { x = chunkX, y = chunkY }
end

function Grid:draw()
    if self.generated then     
        -- do not iterate chunksss broo, you have currentChunk -_-
        for chunk_x, row in pairs(self.chunks) do
            for chunk_y, chunk in pairs(row) do
                if chunk_x == self.currentChunk.x and chunk_y == self.currentChunk.y then
                    chunk:draw()
                end
            end
        end
    end
end