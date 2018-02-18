Object = {
    colision = true,
    identifier = 'Object',
    color = {255,255,255,255},
    dim = {x = 100, y = 200,h = 10, w = 10}

}
function Object:new(o)
    o = o or {}
    setmetatable(o,self)
    self.__index = self
    return o
end

function Object:getComponent()
    for k,v in ipairs(level) do
        if v == self then return k end
    end
end

function Object:draw()
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(self.color)
    love.graphics.rectangle('fill', self.dim.x, self.dim.y, self.dim.w or 10, self.dim.h or 10)
    love.graphics.setColor(r,g,b,a)
end
function Object:update(dt)
    local x1 = player.x
    local y1 = player.y
    local x2 = self.dim.x + self.dim.w/2
    local y2 = self.dim.y + self.dim.h/2
    local vecX = (x2 - x1)
    local vecY = (y2 - y1)
    local vecLength = math.sqrt(vecX^2 + vecY^2)
    vecX = vecX/vecLength
    vecY = vecY/vecLength
    local playerPoint = {x = player.x + vecX*player.hitRadius, y = player.y + vecY*player.hitRadius }

    if (playerPoint.x >= self.dim.x and playerPoint.x <= self.dim.x + self.dim.w) and (playerPoint.y >= self.dim.y and playerPoint.y <= self.dim.y + self.dim.h) then
        local onePoint = false
        if playerPoint.x == self.dim.x or player.x == self.dim.x + self.dim.w or player.y == self.dim.y or player.y == self.dim.y + self.dim.h  then
            onePoint = true
        end
        player:colision(self:getComponent(),vecX,vecY,onePoint)
    end
end
--obj Subclasses

objFence = Object:new({identifier = 'fence',dim = {x = 20, y = 15, w = 20, h = 15}})

--instances

level[(#level or 0) +1] = objFence:new({dim = {x = 20, y = 60, w = 70, h=10} })
