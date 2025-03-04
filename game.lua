local gamera = require "libs/gamera"

Game = Object:extend();

function Game:init()
    _G.G = self;

    self:set_globals();
end

function Game:start_up()
    self:camera_init()

    self.grid = Grid()
    self.grid:generate()

    self.player = Player()
end

function Game:update(dt)
    G.DEBUG_VALUES = {}
    
    G.DEBUG_VALUES["FPS"] = love.timer.getFPS()

    self.grid:update(dt)

    self.player:handleMovement(dt)
    self.cam:lookAt(self.player)
end

function Game:draw()
    self.cam:draw(
        function(l, t, w, h)
            self:draw_background(l, t, w, h)
            self.grid:draw()
            self.player:draw()
        end
    )

    local stats = love.graphics.getStats()

    G.DEBUG_VALUES["TEXTURE_MEM_USED (MB)"] = stats.texturememory / 1024 / 1024
    G.DEBUG_VALUES["DRAW CALLS"] = stats.drawcalls
    G.DEBUG_VALUES["DRAWCALLS_BATCHED"] = stats.drawcallsbatched
    G.DEBUG_VALUES["IMAGES_LOADED"] = stats.images

    love.graphics.push()
        local index = 0
        for key, debug_value in pairs(G.DEBUG_VALUES) do
            love.graphics.print(key .. ": " .. debug_value, 10, 10 + 20 * index)
            index = index + 1
        end
    love.graphics.pop()
end

function Game:keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end
end


function Game:mousepressed(x, y, button)
    self.grid:mousepressed(x, y, button)
end

function Game:wheelmoved(dx, dy)
    self:handle_zoom(dy)
end

function Game:mousemoved(x, y, dx, dy, istouch)
    self.grid:mousemoved(x, y)
end

function Game:draw_background(l, t, w, h)
    love.graphics.push()
        love.graphics.setColor(0.3, 0, 0.7, 1 - ((G.player.T.y * 3) / G.WORLD_HEIGHT))
        love.graphics.rectangle('fill', l, t, w, h)
        love.graphics.setColor(1, 1, 1, 1)
    love.graphics.pop()
end

function Game:camera_init()
    local width, height = love.graphics.getDimensions()

    local scaleX = width / G.CAMERA.VIRTUAL_WIDTH
    local scaleY = height / G.CAMERA.VIRTUAL_HEIGHT
    local scaleFactor = math.min(scaleX, scaleY)

    self.cam = gamera.new(0, 0, G.WORLD_WIDTH, G.WORLD_HEIGHT)

    self.CAMERA.SCALE_FACTOR = scaleFactor
    self.cam:setScale(scaleFactor)
end

function Game:handle_zoom(dy)
    if self.cam then
        local scaleFactor = self.cam:getScale()

        local minZoom = G.CAMERA.SCALE_FACTOR * 0.7 
        local maxZoom = G.CAMERA.SCALE_FACTOR * 2.0

        local zoomFactor = 1.1

        if dy > 0 then
            -- zoom in    
            local newScale = scaleFactor * zoomFactor
            if newScale <= maxZoom then
                self.cam:setScale(newScale)
            end
        elseif dy < 0 then
            -- zoom out
            local newScale = scaleFactor / zoomFactor
            if newScale >= minZoom then
                self.cam:setScale(newScale)
            end
        end

        G.DEBUG_VALUES["SCALE"] = self.cam:getScale()
    end
end