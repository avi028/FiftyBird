pause = class{__includes = BaseState}

function pause:init()
    self.play_obj = null
end

function pause:enter(params)
    if params['state'] == play_state then
        sounds['intro']:play()
        self.play_obj = params['params'] 
    end
end

function pause:update(dt)
    if love.keyboard.wasKeyPressed('p') then
        forward_params = {
            ['state'] = pause_state,
            ['params'] = self.play_obj
        }
        gStateMachine:change(play_state,forward_params)
    end
end

function pause:render()
    self.play_obj:render()
end