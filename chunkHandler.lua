chunkHandler = {currentChunkX = 0, currentChunkY = 0, lastChunkX =0, lastChunkY = 0}
chunkHandler.width = 5 --might change varname later as it is misleading. Ammount of chunks in the X axis
chunkHandler.height = 5 -- ammount of chunks in the y axis

function chunkHandler:update(dt)
    self.currentChunkX, self.currentChunkY = player.chunkX, player.chunkY
    if ((self.currentChunkX ~= self.lastChunkX) or (self.currentChunkY ~= self.lastChunkY)) then
        print('Changed. Last: '..self.lastChunkX..', '..self.lastChunkY..' ; Current: '..self.currentChunkX..', '..self.currentChunkY)
        self.lastChunkX,self.lastChunkY = self.currentChunkX, self.currentChunkY


        local ca,cb = self.currentChunkX, self.currentChunkY
        local w,h = self.width, self.height
        --rewrite the chunk handling system + world system

    end
end

function chunkHandler:updateWorld(dt)

end

function chunkHandler:drawWorld()

end
