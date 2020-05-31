--[[
	this is the class that creates the first scene the player sees when the game loads.
--]]

SceneSprites = Core.class(Sprite)

function SceneSprites:init()

	--first, start out with a dark screen
	application:setBackgroundColor(COLOR_WHITE)

	local LEFT = 0
	local TOP = 0
	local WIDTH = APP_WIDTH - 2 * MINX
	local HEIGHT = APP_HEIGHT - 2 * MINY
	local D = 2
	local SPOTS = math.floor(WIDTH / (TILE_WIDTH + D))
	
	DEBUG(LEFT, TOP, WIDTH, HEIGHT, SPOTS)

	local sprites = Pixel.new(COLOR_WHITE, 1, WIDTH, HEIGHT)
	sprites:setPosition(LEFT, TOP)

	-- Draw Grid
	for x = LEFT, WIDTH, TILE_WIDTH + D do
		local line = Pixel.new(COLOR_BLUE, 1, D, HEIGHT)
		line:setPosition(x, TOP)
		sprites:addChild(line)
	end
	for y = TOP, HEIGHT, TILE_HEIGHT + D do
		local line = Pixel.new(COLOR_RED, 1, WIDTH, D)
		line:setPosition(LEFT, y)
		sprites:addChild(line)
	end

	local x = LEFT + D
	local y = TOP + D

	--[[
	-- Draw Characters
	for key, value in ipairs(manual.lists["monsters"]) do
		local bitmap = manual:getSprite(LAYER_MONSTERS, value.textureName)
		sprites:addChild(bitmap)
		bitmap:setPosition(x, y)
		x = x + TILE_WIDTH + D
	end
	--]]
	
	-- Draw Light Shadows
	x = LEFT + D
	local pack = manual.lists["light"].pack
	for i = 0, 5 do
		local bitmap = manual:getSprite(LAYER_LIGHT, i)
		bitmap:setPosition(x, y)
		sprites:addChild(bitmap)
		--DEBUG("Bitmap", x, y, bitmap:getSize())
		x = x + TILE_WIDTH + D
	end

	-- Draw Health Bars
	x = x + D
	local pack = manual.lists["health"].pack
	for i = 0, 10 do
		local bitmap = manual:getSprite(LAYER_HP, i)
		bitmap:setPosition(x + TILE_WIDTH/2, y + TILE_WIDTH /2)
		sprites:addChild(bitmap)
		--DEBUG("Bitmap", x, y, bitmap:getSize())
		x = x + TILE_WIDTH + D
	end

	local textures = CharacterAnimation.textureData
	local clips = {}
	-- regular scale
	for i = 1, #textures do
		if (i-1) % SPOTS == 0 then
			y = y + TILE_HEIGHT + D
			x = LEFT + D
		end
		local mc = CharacterAnimation.new(textures[i])
		if not mc then break end
		mc:setPosition(x + 50, y + 50)
		mc:setScale(1)
		sprites:addChild(mc)
		table.insert(clips, mc)
		x = x + 3 * (TILE_WIDTH + D)
	end

	-- scale
	--[[
	local SCALE = 2
	y = y - (TILE_HEIGHT + D)
	for i = 1, #textures do
		if SCALE * (i-1) % SPOTS == 0 then
			y = y + SCALE * (TILE_HEIGHT + D)
			x = LEFT + D
		end
		local mc = CharacterAnimation.new(textures[i])
		if not mc then break end
		mc:setPosition(x, y)
		mc:setScale(SCALE)
		sprites:addChild(mc)
		table.insert(clips, mc)
		x = x + SCALE * (TILE_WIDTH + D)
	end
	--]]
		
	self:addEventListener(Event.KEY_DOWN, function(event)
		local actions = {[KeyCode.I] = "IDLE", [KeyCode.W] = "WALK", [KeyCode.R] = "RUN", [KeyCode.J] = "JUMP", 
						[KeyCode.A] = "ATTACK", [KeyCode.NUM_1] = "ATTACK_01", [KeyCode.NUM_2] = "ATTACK_02", 
						[KeyCode.H] = "HURT", [KeyCode.D] = "DIE"}
		
		--DEBUG(event.keyCode, KeyCode.I, actions[KeyCode.I], actions[event.keyCode])

		for i = 1, #clips do
			--DEBUG(i, event.keyCode, actions[event.keyCode])
			clips[i]:go(actions[event.keyCode])
		end		
	end)
	
	local commands = TextField.new(FONT_MEDIUM, "I W R J A 1 2 H D")
	commands:setPosition(1200, 70)
	sprites:addChild(commands)
	
	self:addChild(sprites)
	
end	

