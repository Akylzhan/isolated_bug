love.graphics.setDefaultFilter('nearest', 'nearest')

love.window.setTitle("Isolated Bug")

fontSmall = love.graphics.newFont('font.ttf', 32)
fontMedium = love.graphics.newFont('font.ttf', 64)
fontLarge = love.graphics.newFont('font.ttf', 128)


sfxChoice = love.audio.newSource('sounds/choice.wav', 'static')
sfxKeyPressed = love.audio.newSource('sounds/keyPressed.wav', 'static')
sfxListing = love.audio.newSource('sounds/listing.wav', 'static')


function displayFPS()
    love.graphics.setFont(fontSmall)
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle('fill', 0, 0, 16, 16)

    love.graphics.setColor(0, 1, 0)
    love.graphics.printf(tostring(love.timer.getFPS()), 0, 0, 16, 'center') 	

    love.graphics.setFont(fontMedium)
end

function randomChoice(t) 
end

function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end
