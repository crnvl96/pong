local WINDOW_WIDTH = 1280
local WINDOW_HEIGHT = 720

function love.load()
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
		fullscreen = false,
		resizable = false,
		vsync = true,
	})
end
