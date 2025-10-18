Scene = class();

function Scene:init()
    -- I think we need to move it to scene manager
    _G.G = self;

    self:set_globals();
end

function Scene:start_up()
    
end

function Scene:update(dt)
    
end

function Scene:draw()
    
end

function Scene:keypressed(key, scancode, isrepeat)
    
end


function Scene:mousepressed(x, y, button)

end

function Scene:wheelmoved(dx, dy)

end

function Scene:mousemoved(x, y, dx, dy, istouch)

end