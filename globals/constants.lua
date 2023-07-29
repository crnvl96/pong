local constants = {}

constants.WINDOW_WIDTH = 1280
constants.WINDOW_HEIGHT = 720

constants.VIRTUAL_WIDTH = 432
constants.VIRTUAL_HEIGHT = 243

constants.PADDLE_SPEED = 200

constants.SMALL_FONT = love.graphics.newFont("font.ttf", 8)
constants.SCORE_FONT = love.graphics.newFont("font.ttf", 32)

constants.sounds = {}

constants.sounds.hit = love.audio.newSource("sound/hit.wav", "static")
constants.sounds.score = love.audio.newSource("sound/score.wav", "static")
constants.sounds.wall_hit = love.audio.newSource("sound/wall_hit.wav", "static")

return constants
