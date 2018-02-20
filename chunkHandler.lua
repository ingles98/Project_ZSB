chunkHandler = {currentChunkX = 0, currentChunkY = 0, lastChunkX =0, lastChunkY = 0}
chunkHandler.width = 5 --might change varname later as it is misleading. Ammount of chunks in the X axis
chunkHandler.height = 5 -- ammount of chunks in the y axis
chunkHandler.chunkSize = 16 -- square root of the ammount of tiles on one layer of a chunk

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
    local w,h,length = self.width,self.height,self.chunkSize

    --generating an empty world map with 5 by 5 (w and h) chunks, each made out of a 16 by 16 grid
    local sin = math.abs(math.sin(tileAngle) *tileSize*math.cos(tileAngle*2))
    local cos = math.abs(math.cos(tileAngle) *tileSize*math.cos(tileAngle*2))
    --objSurface:new({dim = {z = z,x = -2*cos +( cos*l) +k*cos, y = -sin + (sin*l) -k*sin , w = tileSize, h=tileSize,pos= {x=k,y=l,z=z}} })
    mapChunk = {}
    loadedMap = {}


    for x,v in ipairs(testChunk) do
        for y,v in ipairs(testChunk[x]) do
            for k,v in ipairs(testChunk[x][y][1]) do -- reads the tile in xY position, layer 1
                if v.type == 'objSurface' then  -- Gotta see how to improve this one here as it won't enable easy adding the classes eg: adding new types of objects, items.
                    loadedMap[x][y][1][k] = objSurface:new(v.o)
                end
            end
        end
    end

    for x,v in ipairs(loadedMap) do
        for y,v in ipairs(testChunk[x]) do
            v:init()
        end
    end
end

function chunkHandler:updateWorld(dt)
    for k,v in ipairs(tempMap) do
        v:update()
    end
end

function chunkHandler:drawWorld()

    local r,g,b,a = love.graphics.getColor()
    love.graphics.setColor(255, 255, 255, 255)
    for k,v in ipairs(tempMap) do
        v:draw()
    end
    love.graphics.setColor(r, g, b, a)
end
