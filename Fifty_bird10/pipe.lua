Pipe = class {}

local PIPE_IMAGE = love.graphics.newImage('pipe.png')
local PIPE_SCROLL = 60
PIPE_HEIGHT = PIPE_IMAGE:getHeight()
PIPE_WIDTH = PIPE_IMAGE:getWidth()

function Pipe:init(orientation,y)
    self.x = VIRTUAL_WIDTH
    self.height = PIPE_IMAGE:getHeight()
    self.width = PIPE_IMAGE:getWidth()
    self.y = y
    self.orientation = orientation 
    -- if orientation == 'upper' then
    --     print(y) 
    --     print('PIPE_HEIGHT' .. PIPE_HEIGHT)
    -- end
end

function Pipe:update(dt)
--    self.x = self.x - PIPE_SCROLL*dt
end

function Pipe:render()
    love.graphics.draw(PIPE_IMAGE,
                        self.x,
                        self.orientation == 'upper' and self.y or self.y,
                        0,
                        1,
                        self.orientation == 'upper' and -1 or 1
                    )
end