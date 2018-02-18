windowFlags = {resizable = true}
curX = love.mouse.getX()
curY = love.mouse.getY()
love.mouse.setVisible(false)
love.window.setMode(600, 400, {resizable = true})
scaleX = love.graphics.getWidth()*1 / 1920
scaleY = love.graphics.getHeight()*1 / 1080
font = love.graphics.newFont(30)
love.graphics.setFont(font)

editor = false
currentCur = 'arrow'
level = {}
