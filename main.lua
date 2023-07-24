local push = require("push")
local constants = require("constants")

local smallFont = love.graphics.newFont("font.ttf", 8)
local scoreFont = love.graphics.newFont("font.ttf", 32)

local playerAScore
local playerBScore
local playerAY
local playerBY

local ballX
local ballY
local ballDX
local ballDY

local gameState

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")

	math.randomseed(os.time())

	gameState = "start"

	playerAScore = 0
	playerBScore = 0

	playerAY = 30
	playerBY = constants.VIRTUAL_HEIGHT - 50

	ballX = constants.VIRTUAL_WIDTH / 2 - 2
	ballY = constants.VIRTUAL_HEIGHT / 2 - 2

	ballDX = math.random(2) == 1 and 100 or -100
	ballDY = math.random(-50, 50)

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
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	elseif key == "enter" or key == "return" then
		if gameState == "start" then
			gameState = "play"
		else
			gameState = "start"

			ballX = constants.VIRTUAL_WIDTH / 2 - 2
			ballY = constants.VIRTUAL_HEIGHT / 2 - 2

			ballDX = math.random(2) == 1 and 100 or -100
			ballDY = math.random(-50, 50)
		end
	end
end

function love.update(dt)
	if love.keyboard.isDown("w") then
		playerAY = math.max(0, playerAY + -constants.PADDLE_SPEED * dt)
	elseif love.keyboard.isDown("s") then
		playerAY = math.min(constants.VIRTUAL_HEIGHT - 20, playerAY + constants.PADDLE_SPEED * dt)
	end

	if love.keyboard.isDown("up") then
		playerBY = math.max(0, playerBY + -constants.PADDLE_SPEED * dt)
	elseif love.keyboard.isDown("down") then
		playerBY = math.min(constants.VIRTUAL_HEIGHT - 20, playerBY + constants.PADDLE_SPEED * dt)
	end

	if gameState == "play" then
		ballX = ballX + ballDX * dt
		ballY = ballY + ballDY * dt
	end
end

function love.draw()
	push:apply("start")

	love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)

	love.graphics.setFont(smallFont)

	love.graphics.printf("Hello pong", 0, 20, constants.VIRTUAL_WIDTH, "center")

	love.graphics.setFont(scoreFont)

	love.graphics.print(tostring(playerAScore), constants.VIRTUAL_WIDTH / 2 - 50, constants.VIRTUAL_HEIGHT / 3)
	love.graphics.print(tostring(playerBScore), constants.VIRTUAL_WIDTH / 2 + 30, constants.VIRTUAL_HEIGHT / 3)

	love.graphics.rectangle("fill", 10, playerAY, 5, 20)
	love.graphics.rectangle("fill", constants.VIRTUAL_WIDTH - 10, playerBY, 5, 20)
	love.graphics.rectangle("fill", ballX, ballY, 4, 4)

	push:apply("end")
end
