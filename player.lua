player = {hp = 100, hitRadius = 100, speed = 190, x = 0, y = 0, chunkX = 0,chunkY = 0}

player.targetX = player.x
player.targetY = player.y



function player:move(vecX,vecY)
    local dt = playerDt
    self.targetX = (self.targetX or 0) + vecX*self.speed*dt/camera.scaleX
    self.targetY = (self.targetY or 0) + vecY*self.speed*dt/camera.scaleY
end
function player:draw()
    camera:set()

    chunkHandler:drawWorld()


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
            if up then self:move(0,-1)
            elseif down then self:move(0,1) end
        end
        if left ~= right then
            if left then
                self:move(-1,0)
            elseif right then
                self:move(1,0)
            end
        end

        self.y = self.targetY
        self.x = self.targetX
    camera.x = self.x - (love.graphics.getWidth()/2)/camera.scaleX
    camera.y = self.y - (love.graphics.getHeight()/2)/camera.scaleY


    local w = chunkHandler.width
    local h = chunkHandler.height

    chunkHandler:updateWorld()

end
