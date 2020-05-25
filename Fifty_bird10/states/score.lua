score = class{__includes = BaseState}

function score:init()
    self.parameters = {}
    self.score =0
    self.badge = null
    self.level_diff = 0
end

function score:enter(params)
    sounds['score_state']:setLooping(true)
    sounds['score_state']:play()
    if params['state'] == play_state then
       self.parameters = params['params']
       self.score = self.parameters['score']
       self.badge = scores[self.parameters['level'] - 1]
       self.level_diff = self.parameters['level'] - self.parameters['init_level']
    end
end

function score:update(dt)
    if love.keyboard.wasKeyPressed('return') then
        gStateMachine:change(select_level_state)
    end
end

function score:render()
    love.graphics.setFont(font_large)
--    love .graphics.draw(self.badge,VIRTUAL_WIDTH/2-self.badge:getWidth(),VIRTUAL_HEIGHT/2 - 2*FONT_LARGE_SIZE-self.badge:getHeight())
    if self.badge~=null and self.level_diff~=0 then
        love .graphics.draw(self.badge,VIRTUAL_WIDTH/2-self.badge:getWidth()/2,VIRTUAL_HEIGHT/2 - 2*FONT_LARGE_SIZE - self.badge:getHeight())
    end
    love.graphics.printf("YOUR SCORE  "..tostring(self.score),0,VIRTUAL_HEIGHT/2 - FONT_LARGE_SIZE,VIRTUAL_WIDTH,'center')
    love.graphics.setFont(font_m)
    if self.parameters['state'] == 'win' then
        love.graphics.printf('CONGRATS YOU WIN !!!\n \n Press Enter to start again .. ', 0 ,2*FONT_LARGE_SIZE + VIRTUAL_HEIGHT/2 - FONT_M_SIZE,VIRTUAL_WIDTH,'center')    
    else
        if self.level_diff > 0 then
            love.graphics.printf('YOU DID good !!\n You went '..tostring(self.level_diff)..' Level UP !!! \n \n Press Enter to try again .. ', 0 ,2*FONT_LARGE_SIZE + VIRTUAL_HEIGHT/2 - FONT_M_SIZE,VIRTUAL_WIDTH,'center')
        else
            love.graphics.printf('OOps !! You Loose !!! \n \n Press Enter to start again .. ', 0 ,2*FONT_LARGE_SIZE + VIRTUAL_HEIGHT/2 - FONT_M_SIZE,VIRTUAL_WIDTH,'center')
        end
    end
end


function score:exit()
    sounds['score_state']:stop()
end