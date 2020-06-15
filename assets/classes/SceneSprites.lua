--[[
	Render all the sprites on screen for testing
--]]

SceneSprites = Core.class(Sprite)


function SceneSprites:init()

	--first, start out with a dark screen
	application:setBackgroundColor(COLOR_BLACK)

	local LEFT = MINX
	local TOP = MINY
	local WIDTH = APP_WIDTH - 2 * MINX
	local HEIGHT = APP_HEIGHT - 2 * MINY
	local D = 2
	local SPOTS = math.floor(WIDTH / (TILE_WIDTH + D))
	
	--DEBUG(MINX, MINY, LEFT, TOP, WIDTH, HEIGHT, SPOTS)

	local sprites = Pixel.new(COLOR_GREY, 1, WIDTH, HEIGHT)
	sprites:setPosition(LEFT, TOP)

	-- Draw Grid
	for x = 0, WIDTH, TILE_WIDTH + D do
		local line = Pixel.new(COLOR_BLACK, 0.2, D, HEIGHT)
		line:setPosition(x, TOP)
		sprites:addChild(line)
	end
	for y = 0, HEIGHT, TILE_HEIGHT + D do
		local line = Pixel.new(COLOR_BLACK, 0.2, WIDTH, D)
		line:setPosition(LEFT, y)
		sprites:addChild(line)
	end

	local x = D
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

	--[[
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
	--]]
	
	-- Draw Loot
	x = x + D
	for i = 1, #manual.lists["loot"] do
		local loot = Loot.new(i, (x+TILE_WIDTH)/TILE_WIDTH, (y+TILE_HEIGHT)/TILE_HEIGHT)
		sprites:addChild(loot)
		DEBUG(loot.name, loot.x, loot.y, loot:getSize())
		x = x + TILE_WIDTH + D
	end

	y = 0

	local textures = CharacterAnimation.spriteData
	local clips = {}
	-- regular scale
	for i = 2, #manual.lists["monsters"] do
		if (i-2) % SPOTS == 0 then
			y = y + TILE_HEIGHT + D
			x = D
		end
		local mc = CharacterAnimation.new(manual:getEntry("monsters", i))
		if not mc then break end
		mc:setPosition(x + 50, y + 50)
		mc:setHealth((i-2) % 11)
		sprites:addChild(mc)
		table.insert(clips, mc)
		x = x + 1 * (TILE_WIDTH + D)
	end

	-- scale
	---[[
	local SCALE = 2
	y = y - (TILE_HEIGHT + D)
	for i = 2, #manual.lists["monsters"] do
		if SCALE * (i-2) % SPOTS == 0 then
			y = y + SCALE * (TILE_HEIGHT + D)
			x = D
		end
		local mc = CharacterAnimation.new(manual:getEntry("monsters", i))
		if not mc then break end
		mc:setPosition(x + 100, y + 100)
		mc:setScale(SCALE * mc:getScale())
		mc:setHealth((i-2) % 11)
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
		
		if event.keyCode == KeyCode.Q then
			sceneManager:changeScene(SCENE_LOBBY, TRANSITION_TIME, TRANSITION)
		end


		for i = 1, #clips do
			--DEBUG(i, event.keyCode, actions[event.keyCode])
			if event.keyCode == KeyCode.F then
				clips[i]:flip()
			end
			clips[i]:go(actions[event.keyCode])
		end		
	end)
	
	local commands = TextField.new(FONT_MEDIUM, "I W R J A 1 2 H D F Q")
	commands:setPosition(BUTTON_MARGIN, HEIGHT - BUTTON_MARGIN)
	sprites:addChild(commands)
	
	self:addChild(sprites)
	
	
	local basicGui = BasicGui.new(nil, 
						nil, nil, 
						"Menagerie", nil,
						"DONE", SCENE_LOBBY)
	self:addChild(basicGui)

	basicGui.button1:addEventListener("click", 
		function()
			currentMap = 0 -- index pointing to the maps we have saved
			currentMapFileName = string.format("%s%02d", MAP_FILE_NAME, currentMap)
			sceneManager:changeScene(SCENE_PLAY, TRANSITION_TIME, TRANSITION) 
		end
	)
end
