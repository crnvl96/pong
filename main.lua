local push = require("lib.push")
local constants = require("globals.constants")
local variables = require("globals.variables")
local Paddle = require("entities.Paddle")
local Ball = require("entities.Ball")

local playerA
local playerB
local ball

local function displayFPS()
	love.graphics.setFont(constants.SMALL_FONT)
	love.graphics.setColor(0, 255, 0, 255)
	love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 10, 10)
end

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.window.setTitle("Pong")

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
		if ball:collides(playerA) then
			ball.dx = -ball.dx * 1.03
			ball.x = playerA.x + 5

			if ball.dy < 0 then
				ball.dy = -math.random(10, 150)
			else
				ball.dy = math.random(10, 150)
			end
		end

		if ball:collides(playerB) then
			ball.dx = -ball.dx * 1.03
			ball.x = playerB.x - 4

			if ball.dy < 0 then
				ball.dy = -math.random(10, 150)
			else
				ball.dy = math.random(10, 150)
			end
		end

		if ball.y <= 0 then
			ball.y = 0
			ball.dy = -ball.dy
		end

		if ball.y >= constants.VIRTUAL_HEIGHT - 4 then
			ball.y = constants.VIRTUAL_HEIGHT - 4
			ball.dy = -ball.dy
		end

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

	love.graphics.setFont(constants.SCORE_FONT)
	love.graphics.print(
		tostring(variables.playerAScore),
		constants.VIRTUAL_WIDTH / 2 - 50,
		constants.VIRTUAL_HEIGHT / 3
	)
	love.graphics.print(
		tostring(variables.playerBScore),
		constants.VIRTUAL_WIDTH / 2 + 30,
		constants.VIRTUAL_HEIGHT / 3
	)

	playerA:render()
	playerB:render()

	ball:render()

	displayFPS()

	push:apply("end")
end
