require "components/cell"

---@class Chunk
Chunk = Node:extend();

function Chunk:init(x, y)
    Node.init(self, 
        { 
            T = { 
                x = x * G.WORLD.BLOCKS_PER_CHUNK_X * G.WORLD.BLOCK_PIXEL_SIZE, 
                y = y * G.WORLD.BLOCKS_PER_CHUNK_Y * G.WORLD.BLOCK_PIXEL_SIZE, 
                w = G.WORLD.BLOCKS_PER_CHUNK_X * G.WORLD.BLOCK_PIXEL_SIZE, 
                h = G.WORLD.BLOCKS_PER_CHUNK_Y * G.WORLD.BLOCK_PIXEL_SIZE
            }
        }
    )

    self.cells = {}

    for row = 1, G.WORLD.BLOCKS_PER_CHUNK_X do
        if not self.cells[row] then
            self.cells[row] = {}
        end

        for col = 1, G.WORLD.BLOCKS_PER_CHUNK_Y do
            self.cells[row][col] = Cell(x * G.WORLD.BLOCKS_PER_CHUNK_X + (row - 1), y * G.WORLD.BLOCKS_PER_CHUNK_Y + (col - 1))
        end
    end
end

function Chunk:draw()
    Node.draw(self, { 0, 1, 0, 0.2 }, 5)

    for _, row in pairs(self.cells) do
        for _, cell in pairs(row) do
            cell:draw()            
        end
    end
end