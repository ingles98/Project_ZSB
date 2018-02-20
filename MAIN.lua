print('Loading Core data..')
print('--Initializing...')
require 'init'
print('--Done. ('..os.clock()..')')
require 'mainCamera'
require 'modules'
require 'player'
require 'gui'
print('Core data loaded. ('..os.clock()..')')
print('Game loaded. Player is at '..player.x..', '..player.y)

function love.update(dt)
    local dt = dt
    mouseUpdate()
    player:update(dt)
    --chunkHandler:update(dt)
end

function love.draw()
    player:draw()
    love.graphics.push()
    love.graphics.setColor(255, 0, 255, 255)
    love.graphics.scale(scaleX, scaleY)
    love.graphics.printf('X: '..love.mouse.getX()..' - Y: '..love.mouse.getY(), 1920 - 650, 45, 500, 'right')
    love.graphics.printf('Xx: - Yy: ', 1920 - 650, 89, 500, 'right')
    --love.graphics.printf('TC - X: '..testChunk[4][3]['dim']['x']..' - Y: '..testChunk[4][3]['dim']['y'], 1920 - 650, 110, 500, 'right')
    love.graphics.printf('Player - X: '..player.x..' - Y: '..player.y, 1920 - 650, 130, 500, 'right')
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
    if key == 'f12' and currentCur == 'arrow' then
        currentCur = 'crosshair'
    elseif key == 'f12' and currentCur == 'crosshair' then
        currentCur = 'arrow'
    end
    if key == 'n' then
        player.targetX = 960
        player.targetY = love.graphics.getHeight()*2 - 960*scaleY
    end

end

function love.mousepressed(x, y, button, isTouch)
    for k,v in ipairs(gui) do
        v:mousePressed()
    end
    if button == 1 and love.keyboard.isDown('lshift') then -- creates tile at the mouse position
        local sin = math.abs(math.sin(tileAngle) *tileSize*math.cos(tileAngle*2))
        local cos = math.abs(math.cos(tileAngle) *tileSize*math.cos(tileAngle*2))
        local x,y = camera.x + love.mouse.getX()/camera.scaleX - cos,camera.y + love.mouse.getY()/camera.scaleY -sin
        local z = 0
        tempMap[#tempMap +1] = objSurface:new({dim = {z = z,x = x, y = y} }) --ALTERAR CARALHO
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

function mouseUpdate()
    x1 = love.mouse.getX()
    y1 = love.mouse.getY()
    x2 = x1 + 12
    y2 = y1
    x3 = x1
    y3 = y1 + 12
end
