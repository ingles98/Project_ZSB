require 'init'
require 'mainCamera'
require 'modules'
require 'player'
require 'objects'
require 'gui'

function love.update(dt)
    local dt = dt
    mouseUpdate()
    player:update(dt)
    for k,v in ipairs(level) do
        v:update(dt)
    end
end

function love.draw()
    player:draw()
    love.graphics.push()
    love.graphics.setColor(255, 0, 255, 255)
    love.graphics.scale(scaleX, scaleY)
    love.graphics.printf('X: '..love.mouse.getX()..' - Y: '..love.mouse.getY(), 1920 - 350, 25, 300, 'right')
    drawGui()
    love.graphics.pop()
    --love.graphics.print(, love.graphics.getWidth() - 100*scaleX, 10*scaleY)
    love.graphics.setColor(255, 255, 255, 255)
end

function love.resize(w, h)
    scaleX = love.graphics.getWidth()*1 / 1920
    scaleY = love.graphics.getHeight()*1 / 1080
    --player.y = player.y - player.y * scaleY
    --player.x = player.x - player.x * scaleX
    --font = love.graphics.newFont(30 * scaleX)
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
end

function mouseUpdate()
    x1 = love.mouse.getX()
    y1 = love.mouse.getY()
    x2 = x1 + 12
    y2 = y1
    x3 = x1
    y3 = y1 + 12
end
function drawMouse()

end
