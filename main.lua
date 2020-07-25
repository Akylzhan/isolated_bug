require 'src/Dependencies'


function love.load()
    love.graphics.setBackgroundColor(0.5,0.5,0.5,1)
    love.graphics.setFont(fontMedium)

    love.keyboard.keysPressed = {}

    gStateStack = StateStack()

    gStateStack:push(MenuState(true))

    counterKeys = 0
end


function love.update(dt)
    gStateStack:update(dt)

    love.keyboard.keysPressed = {}
    counterKeys = 0
end

function love.draw()
    love.graphics.setColor(1,1,1,1)
    gStateStack:render()
    
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    counterKeys = counterKeys + 1
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end