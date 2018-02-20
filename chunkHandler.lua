chunkHandler = {currentChunkX = 0, currentChunkY = 0, lastChunkX =0, lastChunkY = 0}
chunkHandler.width = 5 --might change varname later as it is misleading. Ammount of chunks in the X axis
chunkHandler.height = 5 -- ammount of chunks in the y axis
chunkHandler.chunkSize = 16 -- square root of the ammount of tiles on one layer of a chunk

local chunkThread = [[
local xx,yy = player.chunkX,player.chunkY
for k,v in ipairs(loadedMap) do
    for cxx=xx-1,xx+1 do
        for cyy=yy-1, yy+1 do
            if (cxx == v.dim.pos.xx) and (cyy == v.dim.pos.yy) then
                v:update(dt)
            else
                v:updateInactive(dt)
            end
        end
    end
end
]]

function chunkHandler:update(dt) -- not active,i guess
    self.currentChunkX, self.currentChunkY = player.chunkX, player.chunkY
    if ((self.currentChunkX ~= self.lastChunkX) or (self.currentChunkY ~= self.lastChunkY)) then
        print('Changed. Last: '..self.lastChunkX..', '..self.lastChunkY..' ; Current: '..self.currentChunkX..', '..self.currentChunkY)
        self.lastChunkX,self.lastChunkY = self.currentChunkX, self.currentChunkY


        local ca,cb = self.currentChunkX, self.currentChunkY
        local w,h = self.width, self.height
        --rewrite the chunk handling system + world system

    end
end

function chunkHandler:initWorld(worldId) --Perhaps will be deprecated..
    -- objSurface:new({dim = {z = z,x = -2*cos +( cos*l) +k*cos, y = -sin + (sin*l) -k*sin , w = tileSize, h=tileSize,pos= {x=k,y=l,z=z}} })
    local w,h,size = self.width,self.height,self.chunkSize

    --generating an empty world map with 5 by 5 (w and h) chunks, each made out of a 16 by 16 grid
    local sin = math.abs(math.sin(tileAngle) *tileSize*math.cos(tileAngle*2))
    local cos = math.abs(math.cos(tileAngle) *tileSize*math.cos(tileAngle*2))
    --objSurface:new({dim = {z = z,x = -2*cos +( cos*l) +k*cos, y = -sin + (sin*l) -k*sin , w = tileSize, h=tileSize,pos= {x=k,y=l,z=z}} })
    map = {}
    loadedMap = {}

    --create map first
    for xx=1,w do
        map[xx]={}
        for yy=1,h do
            map[xx][yy] = {}
            for x=1,size do
                map[xx][yy][x] = {}
                for y=1,size do
                    map[xx][yy][x][y] = {active = 'active'}
                    for z=1,1 do
                        map[xx][yy][x][y][z] = {}
                        local length = #map[xx][yy][x][y][z]
                        local k,l,z = x,y,z
                        map[xx][yy][x][y][z][length +1] = {type = 1, tbl ={dim = {pos= {x=k,y=l,z=z,xx=xx,yy=yy}} } }

                    end
                end
            end
        end
    end

    --load the whole map to the game
    for xx,v in ipairs(map) do
        for yy,v in ipairs(map[xx]) do
            for x,v in ipairs(map[xx][yy]) do
                for y,v in ipairs(map[xx][yy][x]) do
                    for z,v in ipairs(map[xx][yy][x][y]) do
                        for k,v in ipairs(map[xx][yy][x][y][z]) do
                            if v.type == 1 then
                                loadedMap[#loadedMap +1] = objSurface:new(v.tbl)
                            end
                        end
                    end
                end
            end
        end
    end
    --
    
end
function chunkHandler:updateWorld(dt)

end

function chunkHandler:drawWorld()
    local dt = love.timer.getDelta()
    if not Drawdelta then Drawdelta = dt else Drawdelta = Drawdelta +dt end
    if Drawdelta >= 1/(love.timer.getFPS()*2.1) then
    local xx,yy = player.chunkX,player.chunkY
    for k,v in ipairs(loadedMap) do

        for cxx=xx-1,xx+1 do
            for cyy=yy-1, yy+1 do
                if (cxx == v.dim.pos.xx) and (cyy == v.dim.pos.yy) then
                    local r,g,b,a = love.graphics.getColor()
                    love.graphics.setColor(255, 255, 255, 255)
                    v:draw()
                    love.graphics.setColor(r, g, b, a)
                else
                    --v:drawInactive()
                end
            end
        end

    end
    Drawdelta = 0
    end
end
