require "components/cell"

---@class Grid
Grid = Node:extend()

function Grid:init()
    -- add chunks
    self.cells = {}
    self.generated = false

    Node:init(self);
end

function Grid:generate()
    -- 1 step
    for row = 1, G.WORLD.WIDTH do
        if not self.cells[row] then
            self.cells[row] = {}
        end
        
        for col = 1, G.WORLD.HEIGHT do
            if not self.cells[row][col] then
                self.cells[row][col] = {}
            end

            self.cells[row][col] = Cell(row - 1, col - 1)
        end
    end

    self.generated = true
end

function Grid:draw()
    if self.generated then     
        for _, row in pairs(self.cells) do
            for _, cell in pairs(row) do
                cell:draw()
            end
        end
    end
end