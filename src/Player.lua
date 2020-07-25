Player = Class{}

function Player:init()
	
	self.width = 28
	self.height = 28

	self.y = 250--VIRTUAL_HEIGHT/2 - 8
	self.x = 960--VIRTUAL_WIDTH/2 - 8

	self.dy = 0
	self.dx = 0
	
	self.image = love.graphics.newImage('img/bug.png')
	self.grid = anim.newGrid(32, 32, self.image:getWidth(), self.image:getHeight())

	self.animation = anim.newAnimation(self.grid('1-3',1), 0.1)

	self.turn = 0
end


function Player:update(dt)

-- x-axis movement
	if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
		self.dx = -180 * dt
	elseif love.keyboard.isDown('right') or love.keyboard.isDown('d') then
		self.dx = 180 * dt
	else self.dx = 0
	end

	-- y-axis movement
	if love.keyboard.isDown('up') or love.keyboard.isDown('w') then
		self.dy = -180 * dt
	elseif love.keyboard.isDown('down') or love.keyboard.isDown('s') then
		self.dy = 180 * dt
	else self.dy = 0
	end

	if self.dx ~= 0 or self.dy ~= 0 then
		self.animation:resume()

		--rotation
		self.turn = math.angle(self.x+self.dx, self.y+self.dy,self.x,self.y) - math.pi/2


	else
		self.animation:pauseAtStart()
	end
	self.animation:update(dt)
end

function Player:render()
	self.animation:draw(self.image, self.x, self.y, self.turn, 1, 1, self.width/2, self.height/2)
end