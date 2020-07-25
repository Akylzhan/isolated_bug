PlayState = Class{__includes = BaseState}


Timer = require 'lib/timer'

function PlayState:init()

    world = bump.newWorld()

    map = sti("map.lua", {'bump'})
    map:bump_init(world)

    player = Player()
    world:add(player, player.x-16, player.y-16, player.width, player.height)

    camera = Camera(player.x, player.y)
    camera:zoom(2)

    imageKeys = love.graphics.newImage('img/keys.png')
    local grid = anim.newGrid(64, 64, imageKeys:getWidth(), imageKeys:getHeight())

    -- animKeys = anim.newAnimation(grid('1-3',1), {0.2,0.3,0.2})
    -- animKeys:pauseAtStart()



    row = {}
    local tbl = {}

    for i=1,12 do
        table.insert(tbl, {anim.newAnimation(grid('1-3',1), {0.2,0.5,0.2}), 384 - player.width/2 + i*64, 256 - player.width/2 + 64})
        tbl[i][1]:pauseAtStart()
    end
    table.insert(row,tbl)
    
    tbl = {}
    for i=1,12 do
        table.insert(tbl, {anim.newAnimation(grid('1-3',1), {0.2,0.5,0.2}), 384 - player.width/2 + i*64, 256 - player.width/2 + 128})
        tbl[i][1]:pauseAtStart()
    end
    table.insert(row,tbl)

    tbl = {}
    for i=1,10 do
        table.insert(tbl, {anim.newAnimation(grid('1-3',1), {0.2,0.5,0.2}), 448-player.width/2+i*64, 256 - player.width/2 + 192})
        tbl[i][1]:pauseAtStart()
    end
    table.insert(row,tbl)


    for _,__ in ipairs(row) do
        for i,j in ipairs(__) do
            Timer.every(
                love.math.random(1.2,2.5), 
                function()
                    if j[1].status == 'playing' then
                        j[1]:pauseAtStart()
                    else j[1]:resume()
                    end
                end
            ) 
        end
    end

end

function PlayState:update(dt)

    if love.keyboard.isDown('escape') then
        gStateStack:push(MenuState(false))
    end

    local x = player.x + player.dx
    local y = player.y + player.dy

    local newX, newY, cols, len = world:move(player, x,y)
    player.x,player.y = newX,newY



    Timer.update(dt)
    camera:move(math.floor(player.x - camera.x)/2, math.floor(player.y - camera.y)/2)
    map:update(dt)

    for _,i in ipairs(row) do
        for __,j in ipairs(i) do
            j[1]:update(dt)
            if j[1].position == 3 then
                sfxKeyPressed:play()
                if j[2] + 70 >= player.x and j[2] - 8 <= player.x then
                    if j[3] + 70 >= player.y and j[3] - 8 <= player.y then
                        gStateStack:pop()
                        gStateStack:push(GameOverState())
                    end
                end
            end
        end
    end
    player:update(dt)

end

function PlayState:render()
    camera:attach()


    -- Translate world so that player is always centred
    local tx = math.floor(player.x + player.width/2 - love.graphics.getWidth() / 4)
    local ty = math.floor(player.y + player.height/2 - love.graphics.getHeight() / 4)

    if tx < 0 then
        tx = 0
    end
    if ty < 0 then
        ty = 0
    end

    -- Draw world
    map:draw(-tx,-ty, 2, 2)
    player:render()

    love.graphics.setColor(1,1,1,0.5)
    for r,i in ipairs(row) do
        for c,j in ipairs(i) do
            j[1]:draw(imageKeys, j[2], j[3])
        end
    end


    love.graphics.setColor(1,1,1,1)
    camera:detach()
end