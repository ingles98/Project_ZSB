gui = {}
guiObj = {
    type = 'class',
    dim = {
        x = 0,
        y = 0,
        w = 0,
        h = 0
    },
    structural = false
}
-- Gui object main class
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


-- instances
