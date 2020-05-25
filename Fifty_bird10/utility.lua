--relaxation
local  rl = 2

function collision_check_FiftyBird(bird , pipe_pair)

    pipe_lower_bird  = collision_check(bird.x+rl,
                                    bird.width-rl*2,
                                    pipe_pair.pipes['lower'].x,
                                    pipe_pair.pipes['lower'].width,
                                    bird.y+rl,
                                    bird.height-rl*2,
                                    pipe_pair.pipes['lower'].y,
                                    pipe_pair.pipes['lower'].height)

    pipe_upper_bird  = collision_check(bird.x+rl,
                                    bird.width-rl*2,
                                    pipe_pair.pipes['upper'].x ,
                                    pipe_pair.pipes['upper'].width,
                                    bird.y+rl,
                                    bird.height-rl*2,
                                    pipe_pair.pipes['upper'].y - pipe_pair.pipes['upper'].height
                                    ,pipe_pair.pipes['upper'].height
                                )

    if(pipe_lower_bird or pipe_upper_bird) then
  --      print('collide' )
    end
    return pipe_lower_bird or pipe_upper_bird                   
end

function collision_check(x1,w1,x2,w2,y1,h1,y2,h2)
    if(x1+w1 >= x2 and x1 <= x2+w2 ) and 
        (y1+h1 >= y2 and y1 <= y2+h2 )then
            return true
    end
    return false
end

function touchdown_check (bird , ground_y)
    if ((bird.y+rl + bird.height-rl*2)  >= ground_y )then
--        print("touchdown")
        return true
    end
    return false    
end


function levelup(level)
    PIPE_SCROLL  =  60 
    if level == 1 then
        PIPE_GAP_MIN =  5* BIRD_HEIGHT
        PIPE_GAP_MAX =  8 *BIRD_HEIGHT
    end    
    if level == 2 then
        PIPE_GAP_MIN =  5* BIRD_HEIGHT
        PIPE_GAP_MAX =  7 *BIRD_HEIGHT
    end    
    if level == 3 then
        PIPE_GAP_MIN =  5* BIRD_HEIGHT
        PIPE_GAP_MAX =  6 *BIRD_HEIGHT
    end    
    if level == 4 then
        PIPE_GAP_MIN =  5* BIRD_HEIGHT
        PIPE_GAP_MAX =  6 *BIRD_HEIGHT
    end    
    if level == 5 then
        PIPE_GAP_MIN =  5* BIRD_HEIGHT
        PIPE_GAP_MAX =  5 *BIRD_HEIGHT
    end    
    if level == 6 then
        PIPE_GAP_MIN =  4* BIRD_HEIGHT
        PIPE_GAP_MAX =  6 *BIRD_HEIGHT
        PIPE_SCROLL  =  65 
    end    
    if level == 7 then
        PIPE_GAP_MIN =  4* BIRD_HEIGHT
        PIPE_GAP_MAX =  5 *BIRD_HEIGHT
        PIPE_SCROLL  =  65 
    end    
    if level == 8 then
        PIPE_GAP_MIN =  4* BIRD_HEIGHT
        PIPE_GAP_MAX =  4 *BIRD_HEIGHT
        PIPE_SCROLL  = 65 
    end    
    if level == 9 then
        PIPE_GAP_MIN =  3* BIRD_HEIGHT
        PIPE_GAP_MAX =  5 *BIRD_HEIGHT
        PIPE_SCROLL  = 70 
    end    
    if level == 10 then
        PIPE_GAP_MIN =  3 *BIRD_HEIGHT
        PIPE_GAP_MAX =  4 *BIRD_HEIGHT
        PIPE_SCROLL  = 70 
    end    
end