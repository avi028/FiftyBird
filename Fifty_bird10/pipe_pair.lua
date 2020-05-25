pipe_pair = class{}

PIPE_GAP_MIN =  5* BIRD_HEIGHT
PIPE_GAP_MAX = 8 *BIRD_HEIGHT
PIPE_SCROLL = 60
local PIPE_MIN_HEIGHT = 30

LAST_Y = 0 

function pipe_pair:init()
    gap = math.random(PIPE_GAP_MAX,PIPE_GAP_MIN)
    if LAST_Y ==0 then
        y_lower =  math.random(
                (VIRTUAL_HEIGHT/5)+gap - PIPE_MIN_HEIGHT,
                VIRTUAL_HEIGHT - PIPE_MIN_HEIGHT
                )
         LAST_Y = y_lower       
    else
        y_lower = LAST_Y + math.random(-20,20)    
    end
    y_upper =  y_lower -gap
    y_lower = y_lower 
    self.x = VIRTUAL_WIDTH + PIPE_SCROLL
    self.width = PIPE_WIDTH
    self.pipes= {
        ['upper'] = Pipe('upper',y_upper),
        ['lower'] = Pipe('lower',y_lower)
    }
    self.remove = false
    self.score = false
end

function pipe_pair:update(dt)
    if self.x > - PIPE_WIDTH then
        self.x = self.x  - PIPE_SCROLL*dt
        self.pipes['upper'].x = self.x
        self.pipes['lower'].x = self.x
    else 
        self.remove = true
    end
end

function pipe_pair:render()
    for k, pipe in pairs(self.pipes) do 
        pipe:render()
    end
end