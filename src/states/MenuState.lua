MenuState = Class{__includes = BaseState}

local highlighted = 1
function MenuState:init(value)
	notPaused = value
end

function MenuState:update(dt)

	if love.keyboard.wasPressed('up') then
		sfxListing:play()
		highlighted = highlighted == 1 and 3 or highlighted-1
		
	elseif love.keyboard.wasPressed('down')then
		sfxListing:play()
		highlighted = highlighted == 3 and 1 or highlighted+1
	end

	if love.keyboard.wasPressed('return') then
		sfxChoice:play()
		
		if highlighted == 1 then	
			gStateStack:pop()
			if notPaused then gStateStack:push(PlayState()) end

		elseif highlighted == 3 then	
        	love.event.quit()
        else
        	gStateStack:pop()
        	gStateStack:push(RulesState())
    	end
    end
end

function MenuState:render()

	love.graphics.setFont(fontLarge)
	love.graphics.setColor(255/255, 0, 180/255)	
	love.graphics.printf('Isolated Bug', 0, love.graphics.getHeight()*1/4 - 32, love.graphics.getWidth(), 'center')

	--reset
	love.graphics.setColor(1,1,1)
	love.graphics.setFont(fontMedium)

	if highlighted == 1 then
		love.graphics.setColor(255/255, 0, 180/255)
	end
	love.graphics.printf('Play', 0, love.graphics.getHeight()/2 - 64, love.graphics.getWidth(), 'center')

	--reset
	love.graphics.setColor(1,1,1)
	

	if highlighted == 2 then
		love.graphics.setColor(255/255, 0, 180/255)
	end	
	love.graphics.printf('Rules', 0, love.graphics.getHeight()/2 - 6, love.graphics.getWidth(), 'center')

	--reset
	love.graphics.setColor(1,1,1)


	if highlighted == 3 then
		love.graphics.setColor(255/255, 0, 180/255)
	end	
	love.graphics.printf('Exit', 0, love.graphics.getHeight()/2 + 50, love.graphics.getWidth(), 'center')	

	--reset
	love.graphics.setColor(1,1,1)
end