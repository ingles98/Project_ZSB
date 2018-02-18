binser = require'binser-master/binser'
require'chunkHandler'
print('--- Setting up variables. ('..os.clock()..')')
windowFlags = {resizable = true}
curX = love.mouse.getX()
curY = love.mouse.getY()
love.mouse.setVisible(true)
love.window.setMode(600, 400, {resizable = true})
scaleX = love.graphics.getWidth()*1 / 1920
scaleY = love.graphics.getHeight()*1 / 1080
font = love.graphics.newFont(30)
love.graphics.setFont(font)

tileAngle = 60
tileSize = 400

editor = false
currentCur = 'arrow'
print('--- Setting up cursor. ('..os.clock()..')')
curArrow_Img = love.image.newImageData('Data/cursor_arrow.png')
curArrow = love.mouse.newCursor(curArrow_Img, curArrow_Img:getWidth()/2, 1)

print('---- Requiring Objects. ('..os.clock()..')')
require 'objects'
local sin = math.abs(math.sin(tileAngle) *tileSize*math.cos(tileAngle*2))
local cos = math.abs(math.cos(tileAngle) *tileSize*math.cos(tileAngle*2))

if not love.filesystem.exists( 'world1' ) then
    print('--- Constructing Level. ('..os.clock()..')')
    level = {}

    world = {}
    chunk = {}
    local w,h = chunkHandler.width, chunkHandler.height
    love.filesystem.createDirectory( 'world1' )

end
