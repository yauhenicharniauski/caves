require "components/cell"

---@class Chunk
Chunk = Node:extend();

function Chunk:init(x, y)
    Node.init(self, 
        { 
            T = { 
                x = x * G.WORLD.CHUNK_WIDTH * G.WORLD.BLOCK_SIZE, 
                y = y * G.WORLD.CHUNK_HEIGHT * G.WORLD.BLOCK_SIZE, 
                w = G.WORLD.CHUNK_WIDTH * G.WORLD.BLOCK_SIZE, 
                h = G.WORLD.CHUNK_HEIGHT * G.WORLD.BLOCK_SIZE
            }
        }
    )

    self.cells = {}

    for row = 1, G.WORLD.CHUNK_WIDTH do
        if not self.cells[row] then
            self.cells[row] = {}
        end

        for col = 1, G.WORLD.CHUNK_HEIGHT do
            self.cells[row][col] = Cell(x * G.WORLD.CHUNK_WIDTH + (row - 1), y * G.WORLD.CHUNK_HEIGHT + (col - 1))
        end
    end
end

function Chunk:draw()
    Node.draw(self, { 0, 1, 0, 1}, 5)

    for _, row in pairs(self.cells) do
        for _, cell in pairs(row) do
            cell:draw()            
        end
    end
end