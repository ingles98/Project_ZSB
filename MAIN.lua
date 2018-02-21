require 'init'


function love.update(dt)
    --player:update(dt)
    --chunkHandler:update(dt)
    threadMgrUpdate()
end

function love.draw()
    --player:draw()
        local k = channel.wTm:pop()
        if k then
            -- i hate my life and i don't know how will i ever do this
        end

    love.graphics.push()
    love.graphics.setColor(255, 0, 255, 255)
    love.graphics.scale(scaleX, scaleY)
    love.graphics.printf('X: '..love.mouse.getX()..' - Y: '..love.mouse.getY(), 1920 - 650, 45, 500, 'right')
    --love.graphics.printf('Xx: '..loadedMap[1]['dim']['x']..'- Yy: '..loadedMap[1]['dim']['y'], 1920 - 650, 89, 500, 'right')
    --love.graphics.printf('TC - X: '..testChunk[4][3]['dim']['x']..' - Y: '..testChunk[4][3]['dim']['y'], 1920 - 650, 110, 500, 'right')
    --love.graphics.printf('Player - X: '..player.chunkX..' - Y: '..player.chunkY, 1920 - 650, 130, 500, 'right')
     love.graphics.print("Current FPS: "..tostring(love.timer.getFPS() ), 10, 10)
    drawGui()
    love.graphics.pop()
    love.graphics.setColor(255, 255, 255, 255)
end

function love.resize(w, h)
    scaleX = love.graphics.getWidth()*1 / 1920
    scaleY = love.graphics.getHeight()*1 / 1080
    love.graphics.setFont(font)
end

function love.keypressed(key, scancode, isrepeat)
    if key == 'p' then
        love.window.setMode(love.graphics.getHeight(), love.graphics.getWidth(),windowFlags)
    end
    if key == 'f10' then
        editor = not editor
    end
end

function love.mousepressed(x, y, button, isTouch)
    for k,v in ipairs(gui) do
        v:mousePressed()
    end
    if button == 1 and love.keyboard.isDown('lshift') then -- creates tile at the mouse position -- DEPRECATED
        local sin = math.abs(math.sin(tileAngle) *tileSize*math.cos(tileAngle*2))
        local cos = math.abs(math.cos(tileAngle) *tileSize*math.cos(tileAngle*2))
        local x,y = camera.x + love.mouse.getX()/camera.scaleX - cos,camera.y + love.mouse.getY()/camera.scaleY -sin
        local z = 0
        tempMap[#tempMap +1] = objSurface:new({dim = {z = z,x = x, y = y} })
        local v = tempMap[#tempMap]
        v:init()
    end
end
function love.wheelmoved(x, y)
    if y > 0 then
        camera:scale(0.04)
    elseif y < 0 then
        camera:scale(-0.04)
    end
end
