player = {hp = 100, hitRadius = 100, speed = 1000, x = 0, y = 0}
player.colisions = {}
player.targetX = player.x
player.targetY = player.y


function player:colision(obj,vecX,vecY,onePoint)
        --self.targetX = self.targetX - vecX*2
        --self.targetY = self.targetY - vecY*2
        self.colisions[#self.colisions +1] = {obj = obj, vecX = vecX, vecY = vecY,onePoint = onePoint}
end
function player:move(vecX,vecY)
    local dt = playerDt

    for k,v in ipairs(self.colisions) do
        if not v.onePoint then
            vecX = -v.vecX
            vecY = -v.vecY
            self['colisions'][k] = nil
        else
            vecX = 0
            vecY = 0
        end
    end
    self.targetX = (self.targetX or 0) + vecX*self.speed*dt/camera.scaleX
    self.targetY = (self.targetY or 0) + vecY*self.speed*dt/camera.scaleY
end
function player:draw()
    camera:set()
    for k,v in ipairs(level) do
        v:draw()
    end
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(255, 255, 255,155)
    love.graphics.circle('fill', self.x, self.y, self.hitRadius)

    --love.graphics.circle('fill', self.x, self.y, self.hitRadius)
    love.graphics.setColor(r, g, b, a)
    camera:unset()
end

function player:update(dt)
    playerDt = dt
    local up,down = love.keyboard.isDown("w"),love.keyboard.isDown("s")
    local left,right = love.keyboard.isDown("a"),love.keyboard.isDown("d")
        if up ~= down then
            if up then
                self:move(0,-1)
                --self.targetY = (self.targetY or 0) - self.speed*dt
            elseif down then
                self:move(0,1)
                --self.targetY = (self.targetY or 0) + self.speed*dt
            end
        end
        if left ~= right then
            if left then
                self:move(-1,0)
                --self.targetX = self.targetX - self.speed*dt
            elseif right then
                self:move(1,0)
                --self.targetX = self.targetX + self.speed*dt
            end
        end

        self.y = self.targetY
        self.x = self.targetX
    camera.x = self.x - (love.graphics.getWidth()/2)/camera.scaleX
    camera.y = self.y - (love.graphics.getHeight()/2)/camera.scaleY

    for k,v in ipairs(level) do
        v:update()
    end
end
