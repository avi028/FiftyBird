Bird = class{}
local GRAVITY = 400
local ANTI_GRAVITY = 8000

BIRD_WIDTH = 38
BIRD_HEIGHT = 23

function Bird:init()
    self.image = love.graphics.newImage('bird.png')
    self.height = self.image:getHeight()
    self.width = self.image:getWidth()
    self.x = VIRTUAL_WIDTH/2 - self.width/2
    self.y = VIRTUAL_HEIGHT/2 - self.height/2
    self.dy = 0
end
 
function Bird:update(dt)
    self.dy = self.dy + GRAVITY*dt
    if love.keyboard.wasKeyPressed('space')then
        self.dy = -ANTI_GRAVITY*dt
        sounds['jump']:play()
    end
    self.y = self.y + self.dy*dt + (GRAVITY*dt*dt)/2
end

function Bird:render()
    love.graphics.draw(self.image,self.x,self.y)
end

