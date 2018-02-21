-- Module Loader
binser = require'binser-master/binser'
require 'threadMgr'
--require 'player'
require 'objects'
--require 'mainCamera'
--require'chunkHandler' --going for world thread
require 'modules'
require 'gui'

-- Initializing environment variables.
global_main = true
windowFlags = {resizable = true}
curX = love.mouse.getX()
curY = love.mouse.getY()
love.mouse.setVisible(true)
love.window.setMode(600, 400, {resizable = true})
scaleX = love.graphics.getWidth()*1 / 1920
scaleY = love.graphics.getHeight()*1 / 1080
font = love.graphics.newFont(30)
love.graphics.setFont(font)

tileAngle = math.rad(30)
tileSize = 400

editor = false
-- Initializing threads
thread.worldThread:start()
channel.mTw:supply({[1] = tileAngle , [2] = tileSize} )

--chunkHandler:initWorld('worldId') -- needs to be worked on.
