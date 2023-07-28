local Class = require("lib.class")
local constants = require("globals.constants")

local Ball = Class({})

function Ball:init(x, y, width, height)
	self.x = x
	self.y = y
	self.width = width
	self.height = height
	self.dx = math.random(2) == 1 and -100 or 100
	self.dy = math.random(-50, 50)
end

function Ball:reset()
	self.x = constants.VIRTUAL_WIDTH / 2 - 2
	self.y = constants.VIRTUAL_HEIGHT / 2 - 2
	self.dx = math.random(2) == 1 and -100 or 100
	self.dy = math.random(-50, 50)
end

function Ball:update(dt)
	self.x = self.x + self.dx * dt
	self.y = self.y + self.dy * dt
end

function Ball:render()
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Ball:collides(target)
	if self.x > target.x + target.width or target.x > self.x + self.width then
		return false
	end

	if self.y > target.y + target.height or target.y > self.y + self.height then
		return false
	end

	return true
end

return Ball
