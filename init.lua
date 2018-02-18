windowFlags = {resizable = true}
curX = love.mouse.getX()
curY = love.mouse.getY()
love.mouse.setVisible(true)
love.window.setMode(600, 400, {resizable = true})
scaleX = love.graphics.getWidth()*1 / 1920
scaleY = love.graphics.getHeight()*1 / 1080
font = love.graphics.newFont(30)
love.graphics.setFont(font)

tileAngle = 60
tileSize = 400



editor = false
currentCur = 'arrow'
curArrow_Img = love.image.newImageData('Data/cursor_arrow.png')
curArrow = love.mouse.newCursor(curArrow_Img, curArrow_Img:getWidth()/2, 1)
--love.mouse.setCursor(curArrow)

level = {}

local map = {}

for z= -1,3 do
    map[z] = {}
    for i=0,20 do
        map[z][i] = {}
        for j=0,20 do
            map[z][i][j] = 0
        end
    end
end
require 'objects'
local sin = math.abs(math.sin(tileAngle) *tileSize*math.cos(tileAngle*2))
local cos = math.abs(math.cos(tileAngle) *tileSize*math.cos(tileAngle*2))

for z,v in pairs(map) do
    for k,v in pairs(map[z]) do
        for l,m in pairs(map[z][k]) do
            --if m == 0 then
                if z == 0 then
                    level[((#level +1) or 0)] = objSurface:new({dim = {z = z,x = -2*cos +( cos*l) +k*cos, y = -sin + (sin*l) -k*sin , w = tileSize, h=tileSize,pos= {x=k,y=l,z=z}} })
                elseif z == 1 and k >= 5 and k <= 15 and l >= 5 and l <= 15 then
                    level[((#level +1) or 0)] = objSurface:new({dim = {z = z,x = -2*cos +( cos*l) +k*cos, y = (-sin + (sin*l) -k*sin) -sin*z*2.5 , w = tileSize, h=tileSize, pos = {x=k,y=l,z=z}} })
                end
            --end
        end
    end
end
--
for k,v in ipairs(level) do
    v:init()
end
