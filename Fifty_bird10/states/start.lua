start = class{__includes = BaseState}
function start:init()
end

function start:update(dt)
   if  love.keyboard.wasKeyPressed('enter') or love.keyboard.wasKeyPressed('return')then
        gStateMachine:change(select_level_state)   
    end
end

function start:enter(params)
    sounds['intro']:setLooping(true)
    sounds['intro']:play()
end

function start:render()
    love.graphics.setFont(font_huge)
    love.graphics.printf("FIFTY BIRD",0,VIRTUAL_HEIGHT/2-FONT_HUGE_SIZE,VIRTUAL_WIDTH,'center')
    love.graphics.setFont(font_m)
    love.graphics.printf("Press Enter To Continue",0,2*FONT_HUGE_SIZE + VIRTUAL_HEIGHT/2-FONT_M_SIZE,VIRTUAL_WIDTH,'center')
end

function start:exit()
end