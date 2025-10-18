local gamera = require "libs/gamera"

-- # Local helpers

local function drawDebugTable(enabled)
    if not enabled then return end

    local stats = love.graphics.getStats()

    G.DEBUG_F3_TABLE[G.DEBUG_F3_ENUM.TEXTURE_MEM_USAGE] = I18n.t("debug.texture_mem_usage", { count = string.format("%.4f", stats.texturememory / 1024 / 1024) })
    G.DEBUG_F3_TABLE[G.DEBUG_F3_ENUM.DRAW_CALLS] = I18n.t("debug.draw_calls", { count = stats.drawcalls })
    G.DEBUG_F3_TABLE[G.DEBUG_F3_ENUM.DRAW_CALLS_BATCHED] = I18n.t("debug.draw_calls_batched", { count = stats.drawcallsbatched })
    G.DEBUG_F3_TABLE[G.DEBUG_F3_ENUM.IMAGES_LOADED] = I18n.t("debug.images_loaded", { count = stats.images })
    
    love.graphics.push()
        local index = 0
        for _, key in ipairs(G.DEBUG_F3_TABLE_ORDER) do
            if G.DEBUG_F3_TABLE[key] then
                love.graphics.print(G.DEBUG_F3_TABLE[key], 10, 10 + 20 * index)
            elseif key ~= G.DEBUG_F3_ENUM.SKIP_LINE then
                love.graphics.print(key .. ": --", 10, 10 + 20 * index)
            end
            index = index + 1
        end
    love.graphics.pop()
end

local function camera_init(scene)
    local width, height = love.graphics.getDimensions()

    local scaleX = width / G.CAMERA.VIRTUAL_WIDTH
    local scaleY = height / G.CAMERA.VIRTUAL_HEIGHT
    local scaleFactor = math.min(scaleX, scaleY)

    scene.cam = gamera.new(0, 0, G.WORLD_WIDTH, G.WORLD_HEIGHT)

    scene.CAMERA.SCALE_FACTOR = scaleFactor
    scene.cam:setScale(scaleFactor)
end

--
Game = class();

function Game:init()
    _G.G = self;

    self:set_globals();

    self.dayNight = love.graphics.newShader("shaders/daynight.glsl")
end

function Game:start_up()
    camera_init(self)

    self.sceneCanvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight())

    self.dayNight:send("colDay",   {1.00, 1.00, 1.00})
    self.dayNight:send("colDusk",  {1.05, 0.85, 0.80})
    self.dayNight:send("colNight", {0.65, 0.75, 1.10})
    
    -- summer time
    -- if time01 = 0..1 = 24, then:
    -- 5AM  = 5 / 24 = 0.208
    -- 8PM  = 20 / 24 = 0.833
    self.dayNight:send("dawn", 0.21)
    self.dayNight:send("dusk", 0.83)

    self.timeSec = 0
    self.dayLength = 15

    self.grid = Grid()
    self.grid:generate()

    self.player = Player()
end

function Game:update(dt)
    G.DEBUG_F3_TABLE = {}
    G.DEBUG_F3_TABLE[G.DEBUG_F3_ENUM.FPS] = I18n.t("debug.fps", { count = love.timer.getFPS() })
    G.DEBUG_F3_TABLE[G.DEBUG_F3_ENUM.TIME] = I18n.t("debug.time", { time = self:getFormattedTime() })

    self.grid:update(dt)

    self.player:handleMovement(dt)
    self.cam:lookAt(self.player)

    self.timeSec = (self.timeSec + dt) % self.dayLength
    self.dayNight:send("time01", self.timeSec / self.dayLength)
end

function Game:draw()
    love.graphics.setCanvas(self.sceneCanvas)
    love.graphics.clear(0,0,0,0)

    self.cam:draw(function(l, t, w, h)
        self:draw_background(l, t, w, h)
        love.graphics.setColor(1,1,1,1)
        self.grid:draw()
        self.player:draw()
    end)

    love.graphics.setCanvas()

    love.graphics.setShader(self.dayNight)
    love.graphics.draw(self.sceneCanvas, 0, 0)
    love.graphics.setShader()

    drawDebugTable(G.DEBUG_F3_ENABLED)
end

function Game:keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end

    if key == "f3" then
        G.DEBUG_F3_ENABLED = not G.DEBUG_F3_ENABLED
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
    end
end

function Game:getFormattedTime()
    local normalized = self.timeSec / self.dayLength
    local totalMinutes = normalized * 24 * 60
    local hour = math.floor(totalMinutes / 60)
    local minute = math.floor(totalMinutes % 60)

    local suffix = "AM"
    if hour >= 12 then
        suffix = "PM"
    end

    local displayHour = hour % 12
    if displayHour == 0 then
        displayHour = 12
    end

    return string.format("%02d:%02d %s", displayHour, minute, suffix)
end