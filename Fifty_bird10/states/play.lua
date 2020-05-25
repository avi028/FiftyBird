require 'bird'
require 'pipe'
require 'pipe_pair'
require 'utility'

play = class{__includes = BaseState}

LEVEL_UP_SCORE = 2

local MIN_SPAWN_TIME = 1.5
local MAX_SPAWN_TIME = 2.5
local PIPE_SPAWN_TIME = 2.0
local SCORE_DISPLAY_HEIGHT = 50

function play:init()
    
    self.collision = false
    self.touchdown = false
    self.win = false

    self.spawntime = PIPE_SPAWN_TIME
    self.bird = Bird()
    self.pipe_pair_table = {}
    self.level = 0
    self.forward_params = {}
    self.total_score = 0
    self.init_level = 0

    self.pause = false
end



function play:enter(params)
    LAST_Y = 0
    if params['state'] == select_level_state then
        self.level = params['params']
        self.init_level = params['params']
        levelup(self.level)
        sounds['intro']:pause()
        sounds['in_game_music']:setLooping(true)
        sounds['in_game_music']:play()
    end
    if params['state'] == pause_state then
        ---self = params['params']
        self.bird = params['params'].bird
        self.pipe_pair_table = params['params'].pipe_pair_table
        self.init_level = params['params'].init_level
        self.level = params['params'].level
        self.spawntime = params['params'].spawntime
        self.forward_params = params['params'].forward_params
        self.total_score = params['params'].total_score
        self.pause = false
        sounds['intro']:pause()
        sounds['in_game_music']:play()
    end    
end

function play:update(dt)
    levelup_render = false
    if love.keyboard.wasKeyPressed('p') then
        self.pause = true
        self.forward_params= {
           ['state'] = play_state,
           ['params'] = self
       }  
       sounds['in_game_music']:pause()
       gStateMachine:change(pause_state,self.forward_params)
    end
    if not self.pause then
        -- bird update[]
        self.bird:update(dt)
        self.touchdown = touchdown_check(self.bird,VIRTUAL_HEIGHT-ground_height)

        if(not self.touchdown) then 
            -- pipe update
            self.spawntime = self.spawntime + dt
            if(self.spawntime >= PIPE_SPAWN_TIME) then 
                table.insert(self.pipe_pair_table,pipe_pair())
                self.spawntime =  0--self.spawntime %PIPE_SPAWN_TIME; 
                if self.level <= MAX_LEVEL/2 then
                    PIPE_SPAWN_TIME = math.random(MIN_SPAWN_TIME*100, MAX_SPAWN_TIME*100)/100
                else
                    PIPE_SPAWN_TIME = (MAX_SPAWN_TIME + MIN_SPAWN_TIME) /2
                end
            end

            for k,pipe in pairs(self.pipe_pair_table) do
                pipe:update(dt)
            end

            for k,pipe in pairs(self.pipe_pair_table) do
                if pipe.remove then
                    table.remove(self.pipe_pair_table,k)    
                end
            end
            -- collison check 
            for k,pipe in pairs(self.pipe_pair_table) do
                self.collision = collision_check_FiftyBird(self.bird,pipe)
                if self.collision then
                    break
                else 
                    if(pipe.score == false and self.bird.x >= pipe.x+pipe.width) then
                        sounds['score']:play()
                        self.total_score = self.total_score +1
                        if self.total_score % LEVEL_UP_SCORE == 0 then
                            sounds['win']:play()
                            self.level = self.level+1
                            LAST_Y = 0
                            if self.level == MAX_LEVEL+1 then
                                self.win = true
                            else
                                levelup(self.level)
                            end
                        end        
                        pipe.score = true
                    end
                end
            end
        end

        if self.collision or self.touchdown  or self.win then 
            parameters = {
                ['score'] = self.total_score,
                ['state'] = '',
                ['level'] = self.level,
                ['init_level'] = self.init_level
            }
            if self.touchdown then
                parameters['state'] = 'touchdown'
                sounds['hurt']:play()
            end
            if self.collision then
                parameters['state'] = 'collision'
                sounds['hurt']:play()
            end
            if self.win then
                parameters['state'] = 'win'
                sounds['win']:play()
            end

            self.forward_params = {
                ['state'] = play_state,
                ['params'] = parameters
            }
            sounds['in_game_music']:stop()
            gStateMachine:change(score_state,self.forward_params)
        end   
    end
end

function play:render()
    --render pipes 
    for k, pipe in pairs(self.pipe_pair_table) do 
        pipe:render()
    end
    -- render bird
    self.bird:render()
    -- render score 
    love.graphics.setFont(font_m)
    love.graphics.printf('LEVEL'..tostring(self.level),0,SCORE_DISPLAY_HEIGHT-FONT_M_SIZE,VIRTUAL_WIDTH,'left')
    love.graphics.printf('SCORE'..tostring(self.total_score),0,SCORE_DISPLAY_HEIGHT-FONT_M_SIZE,VIRTUAL_WIDTH,'right')
    if not self.pause then
        love.graphics.printf('Press P to PAUSE ... ' , 0,2*FONT_M_SIZE+SCORE_DISPLAY_HEIGHT-FONT_M_SIZE,VIRTUAL_WIDTH,'center')
    else
        love.graphics.printf('Press P to START AGAIN ... ' , 0,2*FONT_M_SIZE+SCORE_DISPLAY_HEIGHT-FONT_M_SIZE,VIRTUAL_WIDTH,'center')
    end

end