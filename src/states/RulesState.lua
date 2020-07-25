RulesState = Class{__includes = BaseState}

function RulesState:init()
    text = 'You are bug that lives under keyboard. Human knows that you are here but cannot see you. Human wants to kill you by pressing keys randomly. You should avoid pressed keys by moving (use WASD or arrow keys to move)'

end


function RulesState:update(dt)
    if counterKeys >= 1 then

        sfxChoice:play()

        gStateStack:pop()

        if #gStateStack.states == 0 then
            gStateStack:push(MenuState(1))
        end
    end
end

function RulesState:render()
    love.graphics.setColor(1,1,1,1)
    love.graphics.rectangle("fill", 0,0,1200,1200)
    
    love.graphics.setFont(fontMedium)
    love.graphics.setColor(255/255, 0, 180/255)
    local width,txt = fontMedium:getWrap(text, 300)
    love.graphics.printf(txt, 0, love.graphics.getHeight()/4 - 64, love.graphics.getWidth(), 'center')

end