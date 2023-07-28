local push = require("lib.push")
local constants = require("globals.constants")
local variables = require("globals.variables")
local Paddle = require("entities.Paddle")
local Ball = require("entities.Ball")

local playerA
local playerB
local ball

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")

	math.randomseed(os.time())

	push:setupScreen(
		constants.VIRTUAL_WIDTH,
		constants.VIRTUAL_HEIGHT,
		constants.WINDOW_WIDTH,
		constants.WINDOW_HEIGHT,
		{
			fullscreen = false,
			resizable = false,
			vsync = true,
		}
	)

	playerA = Paddle(10, 30, 5, 20)
	playerB = Paddle(constants.VIRTUAL_WIDTH - 10, constants.VIRTUAL_HEIGHT - 30, 5, 20)

	ball = Ball(constants.VIRTUAL_WIDTH / 2 - 2, constants.VIRTUAL_HEIGHT / 2 - 2, 4, 4)

	variables.gameState = "start"
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	elseif key == "enter" or key == "return" then
		if variables.gameState == "start" then
			variables.gameState = "play"
		else
			variables.gameState = "start"
			ball:reset()
		end
	end
end

function love.update(dt)
	if love.keyboard.isDown("w") then
		playerA.dy = -constants.PADDLE_SPEED
	elseif love.keyboard.isDown("s") then
		playerA.dy = constants.PADDLE_SPEED
	else
		playerA.dy = 0
	end

	if love.keyboard.isDown("up") then
		playerB.dy = -constants.PADDLE_SPEED
	elseif love.keyboard.isDown("down") then
		playerB.dy = constants.PADDLE_SPEED
	else
		playerB.dy = 0
	end

	if variables.gameState == "play" then
		ball:update(dt)
	end

	playerA:update(dt)
	playerB:update(dt)
end

function love.draw()
	push:apply("start")

	love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

	love.graphics.setFont(constants.SMALL_FONT)

	if variables.gameState == "start" then
		love.graphics.printf("Welcome to Pong!", 0, 20, constants.VIRTUAL_WIDTH, "center")
	else
		love.graphics.printf("Play ball!", 0, 20, constants.VIRTUAL_WIDTH, "center")
	end

	playerA:render()
	playerB:render()

	ball:render()

	push:apply("end")
end
