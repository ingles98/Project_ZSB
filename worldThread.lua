require'threadMgr'
    require 'love.audio'
    require 'love.event'
    require 'love.graphics'
    require 'love.image'
    require 'love.joystick'
    require 'love.keyboard'
    require 'love.math'
    require 'love.mouse'
    require 'love.physics'
    require 'love.sound'
    require 'love.system'
    require 'love.timer'
    require 'love.touch'
    require 'love.video'
    require 'love.window'
    require 'love.thread'
binser = require'binser-master/binser'
require'mainCamera'
require'objects'
--init
local v = channel.mTw:demand()
tileAngle,tileSize = v[1],v[2]

chunkHandler = {currentChunkX = 0, currentChunkY = 0, lastChunkX =0, lastChunkY = 0}
chunkHandler.width = 5 --might change varname later as it is misleading. Ammount of chunks in the X axis
chunkHandler.height = 5 -- ammount of chunks in the y axis
chunkHandler.chunkSize = 16 -- square root of the ammount of tiles on one layer of a chunk

local w,h,size = chunkHandler.width,chunkHandler.height,chunkHandler.chunkSize

--generating an empty world map with 5 by 5 (w and h) chunks, each made out of a 16 by 16 grid
sin = math.abs(math.sin(tileAngle) *tileSize*math.cos(tileAngle*2))
cos = math.abs(math.cos(tileAngle) *tileSize*math.cos(tileAngle*2))
--objSurface:new({dim = {z = z,x = -2*cos +( cos*l) +k*cos, y = -sin + (sin*l) -k*sin , w = tileSize, h=tileSize,pos= {x=k,y=l,z=z}} })

map = {}
loadedMap = {}

--create map first, change here to load from file/files
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
--load the map
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
function updateWorld()
    local dt = love.timer.getDelta()
    player:update()
    for k,v in ipairs(loadedMap) do
        v:update(dt)
    end
end
function drawWorld()
        channel.wTm:push(map)
        player:draw()
end
--main loop
while true do
    updateWorld()
    drawWorld()
end
