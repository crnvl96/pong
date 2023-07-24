local push = require("push")
local constants = require("constants")

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")

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
	end
end

function love.draw()
	push:apply("start")
	love.graphics.printf("Hello pong", 0, constants.VIRTUAL_HEIGHT / 2 - 6, constants.VIRTUAL_WIDTH, "center")
	push:apply("end")
end
