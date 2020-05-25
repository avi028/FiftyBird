push = require 'push'
class = require 'class'

WINDOW_WIDTH = 1080
WINDOW_HEIGHT = 720 
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- user defined classes 
require './states/BaseState'
require './states/start'
require './states/select_level'
require './states/countdown'
require './states/play'
require './states/pause'
require './states/score'

require 'StateMachine'

-- For infinite scroll choose loopback point 
-- to be the minimum imge pixel width which is 
-- repeatable over whole image

local background =love.graphics.newImage('background.png')
background_height = 288
background_width = 1157
local background_speed = 30
local background_scroll = 0
local background_loop_back_point = 413 

local ground =love.graphics.newImage('ground.png')
ground_height = 16
ground_width = 1100
local ground_speed = 60
local ground_scroll = 0
local ground_loop_back_point = 7

-- states
start_state = 'start'
select_level_state = 'select_level'
countdown_state = 'countdown'
play_state = 'play'
pause_state = 'pause'
score_state = 'score'

-- badges
scores = {
    [1] = love.graphics.newImage('/badges/score1.png'),
    [2] = love.graphics.newImage('/badges/score2.png'),
    [3] = love.graphics.newImage('/badges/score3.png'),
    [4] = love.graphics.newImage('/badges/score4.png'),
    [5] = love.graphics.newImage('/badges/score5.png'),
    [6] = love.graphics.newImage('/badges/score6.png'),
    [7] = love.graphics.newImage('/badges/score7.png'),
    [8] = love.graphics.newImage('/badges/score8.png'),
    [9] = love.graphics.newImage('/badges/score9.png'),
    [10] = love.graphics.newImage('/badges/score10.png'),
}

--sounds 
sounds = {
    ['intro'] = love.audio.newSource('/sounds/intro.wav','static'),
    ['exp'] = love.audio.newSource('/sounds/explosion.wav','static'),
    ['jump'] = love.audio.newSource('/sounds/jump.wav','static'),
    ['score'] = love.audio.newSource('/sounds/score.wav','static'),
    ['hurt'] = love.audio.newSource('/sounds/hurt.wav','static'),
    ['win'] = love.audio.newSource('/sounds/win.wav','static'),
    ['countdown_single'] = love.audio.newSource('/sounds/countdown_single.wav','static'),
    ['in_game_music'] = love.audio.newSource('/sounds/in_game_music.mp3','static'),
    ['score_state'] = love.audio.newSource('/sounds/score_state_music.wav','static')
}

-- font sizes
FONT_HUGE_SIZE = 50
FONT_LARGE_SIZE  = 28
FONT_M_SIZE = 15
FONT_SMALL_SIZE = 8

-- fonts ./fonts/flappy.ttf
font_huge = love.graphics.newFont('/fonts/flappy.ttf',FONT_HUGE_SIZE)
font_large = love.graphics.newFont('/fonts/flappy.ttf',FONT_LARGE_SIZE)
font_m = love.graphics.newFont('/fonts/flappy.ttf',FONT_M_SIZE)
font_small = love.graphics.newFont('/fonts/font.ttf',FONT_SMALL_SIZE)

function love.load()
    -- initialize nearest neighbour filter
    love.graphics.setDefaultFilter('nearest','nearest')

    --set title
    love.window.setTitle('FIFTY BIRD')

    -- seed the random function 
    math.randomseed(os.time())

    -- initialize virtual resolution
    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{
        fulscreen  = false,
        vsync = true,
        resize = true
    }) 

    -- initialize the states 
        gStateMachine = StateMachine {
            [start_state] = function() return start() end,
            [select_level_state] = function () return select_level() end ,
            [countdown_state] = function () return countdown() end ,
            [play_state] = function () return play() end ,
            [pause_state] = function () return pause() end, 
            [score_state] = function () return score() end 
        }
        gStateMachine:change(start_state)
    love.keyboard.keyPressed = {}
end

function love.resize(w,h)
    push:resize(w,h)
end


function love.update(dt)
    -- background udapte
    background_scroll = (background_scroll+background_speed*dt)%background_loop_back_point
    ground_scroll = (ground_scroll+ground_speed*dt)%ground_loop_back_point
    gStateMachine:update(dt)
    love.keyboard.keyPressed = {}
end

function love.keypressed(key)
    love.keyboard.keyPressed[key] = true
    if key == 'escape' then
        love.event.quit()
    end
end

function love.keyboard.wasKeyPressed(key)
    if love.keyboard.keyPressed[key] == true then
        return true
    else
        return false
    end
end 

function love.draw()
    push:start()
    --render backgorund 
    love.graphics.draw(background,0-background_scroll,VIRTUAL_HEIGHT-(background_height+ground_height))
    -- state_render
    gStateMachine:render()
    --render ground
    love.graphics.draw(ground,0-ground_scroll,VIRTUAL_HEIGHT-ground_height)
    push:finish()
end

