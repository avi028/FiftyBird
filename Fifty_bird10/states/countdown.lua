countdown = class{__includes = BaseState}

local COUNTDOWN = 3
local  COUNTDOWN_TIME = 2

function countdown:init()
    self.count = COUNTDOWN
    self.count_timer = 0
    self.level = 0
    self.forward_params = {}
end

function countdown:enter(params)
    if params['state'] == select_level_state then
        self.forward_params = params
    end
end

function countdown:update(dt)
    self.count_timer =  self.count_timer + dt 
    if self.count_timer >= COUNTDOWN_TIME then
        sounds['countdown_single']:stop()
        self.count  = self.count  - 1
        self.count_timer = self.count_timer % COUNTDOWN_TIME           
        sounds['countdown_single']:play()
    end
    if self.count == 0 then
        gStateMachine:change(play_state,self.forward_params)   
    end
end


function countdown:render()
    love.graphics.setFont(font_huge)
    love.graphics.printf(tostring(self.count) , 0 , VIRTUAL_HEIGHT/2 - FONT_LARGE_SIZE ,VIRTUAL_WIDTH,'center')
    love.graphics.setFont(font_m)
    love.graphics.printf('USE SPACE KEY TO JUMP \n THE MORE TIME YOU PRESS CONTINIOUSLY THE MORE HIGH YOU GO' , 0 , FONT_M_SIZE + FONT_LARGE_SIZE + VIRTUAL_HEIGHT/2 - FONT_M_SIZE ,VIRTUAL_WIDTH,'center')
end

function countdown:exit()
    self.count = COUNTDOWN
    self.count_timer = 0
    sounds['countdown_single']:stop()
end