GameOverState = Class{__includes = BaseState}

function GameOverState:update(dt)
    if love.keyboard.isDown('escape') then
        sfxChoice:play()
        gStateStack:pop()
        gStateStack:push(MenuState(1))
    end
end

function GameOverState:render()
    love.graphics.setColor(1,1,1,0.7)
    love.graphics.rectangle("fill", 0,0,1200,1200)
    
    love.graphics.setFont(fontLarge)
    love.graphics.setColor(255/255, 0, 180/255)
    love.graphics.printf('GAME OVER!', 0, love.graphics.getHeight()/2 - 64, love.graphics.getWidth(), 'center')

end