player = {hp = 100, hitRadius = 100, speed = 190, x = 200, y = 2, chunkX = 1,chunkY = 1}
player.targetX = player.x
player.targetY = player.y
function player:move(vecX,vecY)
    local dt = playerDt
    self.targetX = (self.targetX or 0) + vecX*self.speed*dt/camera.scaleX
    self.targetY = (self.targetY or 0) + vecY*self.speed*dt/camera.scaleY
end
function player:draw()
    --camera:set()
    --chunkHandler:drawWorld()
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(255, 255, 255,155)
    love.graphics.circle('fill', self.x, self.y, self.hitRadius)

    --love.graphics.circle('fill', self.x, self.y, self.hitRadius)
    love.graphics.setColor(r, g, b, a)
    --camera:unset()
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
end

--objects_environment
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

function Object:init()
end

function Object:draw()
    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(self.color)
    love.graphics.rectangle('fill', self.dim.x, self.dim.y, self.dim.w or 10, self.dim.h or 10)
    love.graphics.setColor(r,g,b,a)
end

function Object:update(dt)
end

objSurface = Object:new({
    colision = false,
    identifier = 'surface',
    color = {255,255,255,100},
    stroke = 0,
    dim = {z = 0, x = 100, y = 200,h = 10, w = 10, pos = {x=0,y=0,z=0,xx=0,yy=0}},
})

function getTile(x,y,z) -- Not yet in use.
    for k,v in ipairs(level) do
        if v.dim.pos == {x,y,z} then return k end
    end
end

function objSurface:new(o)
    o = o or {}
    setmetatable(o,self)
    self.__index = self
    o:init()
    return o
end

function objSurface:init()
    self.identifier = self.identifier
    local sin = math.abs(math.sin(tileAngle) *tileSize*math.cos(tileAngle*2))
    local cos = math.abs(math.cos(tileAngle) *tileSize*math.cos(tileAngle*2))

    local k = self.dim.pos.x
    local l = self.dim.pos.y
    local z = self.dim.pos.z
    local xx,yy = self.dim.pos.xx, self.dim.pos.yy

    self.dim.x = (-2*cos +( cos*l) +k*cos) + 16*cos*xx + 16*cos*yy -((-2*cos +( cos) +cos) + 16*cos + 16*cos)
    self.dim.y = (-sin + (sin*l) -k*sin) + 16*sin*yy - 16*sin*xx
    self.dim.z = z
    local x = self.dim.x
    local y = self.dim.y
    --{z = z,x = -2*cos +( cos*l) +k*cos, y = -sin + (sin*l) -k*sin}

    if not self.dim.w or not self.dim.h then self.dim.w,self.dim.h = tileSize,tileSize end
    if not self.dim.pos then self.dim.pos = {x=1,y=1,z=1} end --sets back default values.
    local w = self.dim.w
    local h = self.dim.h
    local a = tileAngle
    local length = math.cos(a*2)*self.dim.w
    local x1 = x
    local y1 = y + math.abs(math.sin(a))*length
    local x2 = x + math.abs(math.cos(a))*length
    local y2 = y
    local x3 = x + 2* math.abs(math.cos(a))*length
    local y3 = y1
    local x4 = x2
    local y4 = y + 2* math.abs(math.sin(a))*length

    local points = {x1,y1,x2,y2,x3,y3,x4,y4}
    self.points = points
    self.color = {255,255,255,255}
end

function objSurface:checkColision(x,y)
  local pos = self.dim.pos
  pos.z = pos.z +1
  local t = self.points
  local x1 = t[1]
  local y1 = t[2]
  local x2 = t[3]
  local y2 = t[4]
  local x3 = t[5]
  local y3 = t[6]
  local x4 = t[7]
  local y4 = t[8]

  local lA = math.sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
  local lB = math.sqrt((x3-x2)*(x3-x2)+(y3-y2)*(y3-y2))
  local lC = math.sqrt((x1-x3)*(x1-x3)+(y1-y3)*(y3-y1))
  local s = (lA + lB + lC)/2
  local a0 = math.sqrt(s*(s-lA)*(s-lB)*(s-lC))*2

  lA = math.sqrt((x1-x)*(x1-x)+(y1-y)*(y1-y))
  lB = math.sqrt((x2-x)*(x2-x)+(y2-y)*(y2-y))
  lC = math.sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))
  s = (lA + lB + lC)/2
  local a1 = math.sqrt(s*(s-lA)*(s-lB)*(s-lC))

  lA = math.sqrt((x3-x)*(x3-x)+(y3-y)*(y3-y))
  lB = math.sqrt((x2-x)*(x2-x)+(y2-y)*(y2-y))
  lC = math.sqrt((x3-x2)*(x3-x2)+(y3-y2)*(y3-y2))
  s = (lA + lB + lC)/2
  local a2 = math.sqrt(s*(s-lA)*(s-lB)*(s-lC))

  lA = math.sqrt((x1-x)*(x1-x)+(y1-y)*(y1-y))
  lB = math.sqrt((x4-x)*(x4-x)+(y4-y)*(y4-y))
  lC = math.sqrt((x1-x4)*(x1-x4)+(y1-y4)*(y1-y4))
  s = (lA + lB + lC)/2
  local a3 = math.sqrt(s*(s-lA)*(s-lB)*(s-lC))

  lA = math.sqrt((x3-x)*(x3-x)+(y3-y)*(y3-y))
  lB = math.sqrt((x4-x)*(x4-x)+(y4-y)*(y4-y))
  lC = math.sqrt((x3-x4)*(x3-x4)+(y3-y4)*(y3-y4))
  s = (lA + lB + lC)/2
  local a4 = math.sqrt(s*(s-lA)*(s-lB)*(s-lC))

  aAll = a1+a2+a3+a4

  a0 = math.floor(a0)
  aAll = math.floor(aAll)
  if a0 == aAll then
      return true
  else
      return false
  end
end
function objSurface:update(dt) -- Indeed this will «probably» need a huge optimization.

    if self:checkColision(camera.x + love.mouse.getX()/camera.scaleX,camera.y + love.mouse.getY()/camera.scaleY) then --checks mouse
      self.stroke = 255
      if love.mouse.isDown(1) then
        self['color'][1] = 0
      end
    else
      self.stroke = 0
    end

    if self:checkColision(player.x,player.y) then
      player.chunkX,player.chunkY = self.dim.pos.xx, self.dim.pos.yy
    end

end

function objSurface:updateInactive(dt)
    if not self.inactive then
        self.inactive = true
        self.inactiveTime = love.timer.getTime()
    else
        local Delta = love.timer.getTime()
        if (Delta - self.inactiveTime) >=5 then
            self = nil
        end
    end
end


function objSurface:draw()
    local br,bg,bb,ba = love.graphics.getColor()
    local r,g,b,a = self.color
    love.graphics.setColor(r, g, b, a)
    love.graphics.polygon('fill',self.points)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.polygon('line',self.points)
    love.graphics.setColor(255, 0, 255, self.stroke)
    love.graphics.polygon('line',self.points)
    love.graphics.setColor(br,bg,bb,ba)
end

function objSurface:drawInactive()
    local br,bg,bb,ba = love.graphics.getColor()
    local r,g,b,a = self.color
    love.graphics.setColor(r, g, b, 100)
    love.graphics.polygon('fill',self.points)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.polygon('line',self.points)
    love.graphics.setColor(255, 0, 255, self.stroke)
    love.graphics.polygon('line',self.points)
    love.graphics.setColor(br,bg,bb,ba)
end



--instances
