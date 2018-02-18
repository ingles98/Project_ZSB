gui = {}
guiObj = {
    type = 'class',
    dim = {
        x = 1,
        y = 1,
        w = 1,
        h = 1
    },
    structural = false
}
function guiObj:new(o)
    o = o or {}
    setmetatable(o,self)
    self.__index = self
    return o
end
function guiObj:draw() end
function guiObj:update() end
function guiObj:mousePressed() end

function drawGui()
    for k,v in pairs(gui) do
        if v.type == not 'cursor' then
            v:draw()
        elseif v.type == 'cursor' and v.id == currentCur then
            v:draw()
        end
    end
end
-- obj sublcasses
guiStructure = guiObj:new()
function guiStructure:draw()
    local r,g,b,a = love.graphics.getColor()
    love.graphics.rectangle('fill', self.dim.x, self.dim.y, self.dim.w, self.dim.h)
    love.graphics.setColor(r, g, b, a)
end

guiCursor = guiObj:new( {dim = {x = 0, y = 0}, type = 'cursor', id = 'none'} )

-- instances

local cur = guiCursor:new({id = 'crosshair'})
function cur:draw()
    local r,g,b,a = love.graphics.getColor()
    local x = love.mouse.getX() /scaleX
    local y = love.mouse.getY() /scaleY
    local scaleX = 1
    local scaleY = 1
    love.graphics.setColor(255, 100, 100, 245)
    love.graphics.circle('fill', x, y, 3*scaleX)
    local x1 = (x -20*scaleX)
    local y1 = y
    local x2 = x1 - (10*scaleX)
    local y2 = y1
    love.graphics.line(x1, y1, x2, y2)
    local x1 = (x +20*scaleX)
    local y1 = y
    local x2 = x1 + (10*scaleX)
    local y2 = y1
    love.graphics.line(x1, y1, x2, y2)
    local x1 = x
    local y1 = y + 20*scaleY
    local x2 = x1
    local y2 = y1 + 10*scaleY
    love.graphics.line(x1, y1, x2, y2)
    local x1 = x
    local y1 = y - 20*scaleY
    local x2 = x1
    local y2 = y1 - 10*scaleY
    love.graphics.line(x1, y1, x2, y2)
    love.graphics.setColor(r,g,b,a)
end
gui[#gui+1] = cur

cur = guiCursor:new({id = 'arrow'})
function cur:draw()
    local r,g,b,a = love.graphics.getColor()
    local x = love.mouse.getX() /scaleX
    local y = love.mouse.getY() /scaleY
    local scaleX = 1
    local scaleY = 1
    poli = {x,y}
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.circle('fill', x, y, 3*scaleX)
    love.graphics.polygon('line', poli)

    love.graphics.setColor(r,g,b,a)
end
gui[#gui+1] = cur
