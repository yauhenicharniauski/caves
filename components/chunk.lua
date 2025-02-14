require "components/cell"

---@class Chunk
Chunk = Node:extend();

local function terrainHeight(x)
    local frequency = 0.02 -- Lower values create smoother hills
    local amplitude = 10    -- Controls the height variation of the terrain
    return math.floor((love.math.noise(G.SEED + x * frequency) * amplitude) + 20) 
    -- The base terrain level is around y = 20, with noise-based variations
end

local function shouldPlaceBlock(x, y)
    local height = terrainHeight(x) -- Get the terrain height for the given x position

    -- oval caves
    local caveNoise = love.math.noise(G.SEED + x * 0.003, G.SEED + y * 0.01)
    if y > 40 and caveNoise > 0.8 then
        return false
    end

    local caveNoise = love.math.noise(G.SEED + x * 0.02, G.SEED + y * 0.03)
    if y > 20 and caveNoise > 0.8 then
        return false 
    end

    local caveNoise = love.math.noise(G.SEED + x * 0.03, G.SEED + y * 0.06)
    if y > 10 and caveNoise > 0.7 then
        return false 
    end
    
    -- Ground layer: place blocks below the terrain height
    if y >= height then
        return true
    end    

    return false -- Don't place blocks above the terrain height
end

function Chunk:init(xGridRelative, yGridRelative)
    Node.init(self, 
        { 
            T = { 
                x = xGridRelative * G.WORLD.BLOCKS_PER_CHUNK_X * G.WORLD.BLOCK_PIXEL_SIZE, 
                y = yGridRelative * G.WORLD.BLOCKS_PER_CHUNK_Y * G.WORLD.BLOCK_PIXEL_SIZE, 
                w = G.WORLD.BLOCKS_PER_CHUNK_X * G.WORLD.BLOCK_PIXEL_SIZE, 
                h = G.WORLD.BLOCKS_PER_CHUNK_Y * G.WORLD.BLOCK_PIXEL_SIZE
            }
        }
    )

    self._grid_x = xGridRelative
    self._grid_y = yGridRelative
    self.cells = {}

    for row = 0, G.WORLD.BLOCKS_PER_CHUNK_X - 1 do
        if not self.cells[row] then
            self.cells[row] = {}
        end

        for col = 0, G.WORLD.BLOCKS_PER_CHUNK_Y - 1 do
            local cellX = row + xGridRelative * G.WORLD.BLOCKS_PER_CHUNK_X
            local cellY = col + yGridRelative * G.WORLD.BLOCKS_PER_CHUNK_Y

            local block = shouldPlaceBlock(cellX, cellY) and Block(cellX, cellY, G.ENUMS.BLOCKS.DIRT, 2) or nil

            self.cells[row][col] = 
                Cell(
                    cellX, 
                    cellY,
                    block
                )
        end
    end
end

function Chunk:update(dt)
    self:calculateVisibleCells(function (cell)
        cell:update(dt)
    end)
end

function Chunk:draw()
    Node.draw(self, { 0, 1, 0, 0.2 }, 5)

    self:calculateVisibleCells(function (cell)
        cell:draw()
    end)
end

function Chunk:mousepressed(x, y, button)
    self:calculateVisibleCells(function (cell)
        cell:mousepressed(x, y, button)
    end)
end

---Calculates visible cells and applies a function to each one.
---@param func fun(cell: Cell)
function Chunk:calculateVisibleCells(func)
    if type(func) == "function" then
        local x1, y1, _, _, x3, y3, _, _ = G.cam:getVisibleCorners()

        local leftMostVisibleX = math.floor(math.max(x1, self.T.x) / G.WORLD.BLOCK_PIXEL_SIZE) - self._grid_x * G.WORLD.BLOCKS_PER_CHUNK_X
        local rightMostVisibleX = math.ceil(math.min(x3, self.T.x + self.T.w) / G.WORLD.BLOCK_PIXEL_SIZE) - self._grid_x * G.WORLD.BLOCKS_PER_CHUNK_X
        local topMostVisibleY = math.floor(math.max(y1, self.T.y) / G.WORLD.BLOCK_PIXEL_SIZE) - self._grid_y * G.WORLD.BLOCKS_PER_CHUNK_Y
        local bottomMostVisibleY = math.ceil(math.min(y3, self.T.y + self.T.h) / G.WORLD.BLOCK_PIXEL_SIZE) - self._grid_y * G.WORLD.BLOCKS_PER_CHUNK_Y

        for x = leftMostVisibleX, rightMostVisibleX do
            if self.cells and self.cells[x] then
                for y = topMostVisibleY, bottomMostVisibleY do
                    if self.cells[x][y] then
                        func(self.cells[x][y])
                    end
                end
            end
        end
    end
end