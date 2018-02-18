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
end

objSurface = {
    colision = false,
    identifier = 'surface',
    color = {255,255,255,255},
    stroke = 0,
    dim = {z = 0, x = 100, y = 200,h = 10, w = 10, pos = {x=0,y=0,z=0}},
}

function getTile(x,y,z) -- Not yet in use.
    for k,v in ipairs(level) do
        if v.dim.pos == {x,y,z} then return k end
    end
end

function objSurface:new(o)
    o = o or {}
    setmetatable(o,self)
    self.__index = self
    return o
end

function objSurface:init()
    local x = self.dim.x
    local y = self.dim.y
    local w = self.dim.w
    local h = self.dim.h
    local a = 60
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
end

function objSurface:getComponent()
    for k,v in ipairs(level) do
        if v == self then return k end
    end
end

function objSurface:update(dt) -- Indeed this will «probably» need a huge optimization.
    local pos = self.dim.pos
    pos.z = pos.z +1

    local x = camera.x + love.mouse.getX()/camera.scaleX
    local y = camera.y + love.mouse.getY()/camera.scaleY
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
        self.stroke = 255
    else
        self.stroke = 0
    end
end


function objSurface:draw()
    local r,g,b,a = 255,255,255,255
    love.graphics.setColor(r, g, b, a)
    love.graphics.polygon('fill',self.points)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.polygon('line',self.points)
    love.graphics.setColor(255, 0, 255, self.stroke)
    love.graphics.polygon('line',self.points)
end



--instances
