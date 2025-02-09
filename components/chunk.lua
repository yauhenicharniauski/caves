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
            local cellX = x * G.WORLD.BLOCKS_PER_CHUNK_X + (row - 1)
            local cellY = y * G.WORLD.BLOCKS_PER_CHUNK_Y + (col - 1)

            local isOre = love.math.noise(G.SEED + cellX * 0.01, G.SEED + cellY * 0.01) > 0.95

            local block = shouldPlaceBlock(cellX, cellY) and Block(cellX, cellY, G.ENUMS.BLOCKS.DIRT, isOre and 1 or 2) or nil

            self.cells[row][col] = 
                Cell(
                    cellX, 
                    cellY,
                    block
                )
        end
    end
end

function Chunk:draw()
    Node.draw(self, { 0, 1, 0, 0.2 }, 5)

    local x1,y1,_,_,x3,y3,_,_ = G.cam:getVisibleCorners()
    for _, row in pairs(self.cells) do
        for _, cell in pairs(row) do
            if 
                cell.T.x > x1 - G.WORLD.BLOCK_PIXEL_SIZE and -- needs to be substructed here because origin is on left top angle
                cell.T.x < x3 and
                cell.T.y > y1 - G.WORLD.BLOCK_PIXEL_SIZE and
                cell.T.y < y3
            then
                cell:draw()    
            end
        end
    end
end