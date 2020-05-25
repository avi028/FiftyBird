select_level = class{__includes = BaseState}

MAX_LEVEL = 10
MIN_LEVEL = 1

function select_level:init()
--    self.level = math.random(MIN_LEVEL,MAX_LEVEL)
        self.level = MIN_LEVEL
        self.forward_params={
            ['state'] = select_level_state,
            ['params'] = None
        }
end

function select_level:enter()
    sounds['intro']:pause()
    sounds['intro']:play()
end

function select_level:update(dt)
    if love.keyboard.wasKeyPressed('up') then
        self.level = self.level + 1
        if self.level > MAX_LEVEL then
            self.level = MIN_LEVEL
        end
    end
    if love.keyboard.wasKeyPressed('down')then    
        self.level = self.level - 1
        if self.level < MIN_LEVEL then
            self.level = MAX_LEVEL
        end
    end
    if love.keyboard.wasKeyPressed('return')then
        Current_level = self.level
        self.forward_params['params'] = self.level
        gStateMachine:change(countdown_state,self.forward_params)
    end
end

function select_level:render()
    love.graphics.setFont(font_huge)
    love.graphics.printf("LEVEL "..tostring(self.level), 0,VIRTUAL_HEIGHT/2-FONT_HUGE_SIZE,VIRTUAL_WIDTH,'center')   
    love.graphics.setFont(font_m)
    love.graphics.printf("Press \nArrow Up to level up \n ARROW DONW to lovel Down !!",0,FONT_HUGE_SIZE+VIRTUAL_HEIGHT/2-FONT_M_SIZE,VIRTUAL_WIDTH,'center')
    love.graphics.setFont(font_small)
    love.graphics.printf("CHOOSE WISELY :)",0,FONT_HUGE_SIZE+3*FONT_M_SIZE+VIRTUAL_HEIGHT/2-FONT_SMALL_SIZE,VIRTUAL_WIDTH,'center')
end

function select_level:exit()
end
