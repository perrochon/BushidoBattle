--[[
	this is the class that creates the first scene the player sees when the game loads.
--]]

SceneSprites = Core.class(Sprite)

function SceneSprites:init()

	--first, start out with a dark screen
	application:setBackgroundColor(COLOR_WHITE)

	local ROWS =9
	local COLUMNS = 18
	local D = 2

	local sprites = Pixel.new(COLOR_WHITE, 1, COLUMNS * (TILE_WIDTH + D), ROWS * (TILE_HEIGHT + D))

	-- Draw Grid
	for x = 0, APP_WIDTH, TILE_WIDTH + D do
		local line = Pixel.new(COLOR_GREEN, 0.8, D, ROWS * TILE_HEIGHT + 2 * D)
		line:setPosition(x, 0)
		sprites:addChild(line)
	end
	for y = 0, ROWS*TILE_HEIGHT + 2 * D, TILE_HEIGHT + D do
		local line = Pixel.new(COLOR_RED, 0.6, COLUMNS * (TILE_WIDTH + D), D)
		line:setPosition(0, y)
		sprites:addChild(line)
	end

	-- Draw Characters
	local x = D
	local y = D
	for key, value in ipairs(manual.lists["monsters"]) do
		local bitmap = manual:getSprite(LAYER_MONSTERS, value.textureName)
		sprites:addChild(bitmap)
		bitmap:setPosition(x, y)
		x = x + TILE_WIDTH + D
	end

	-- Draw Light Shadows
	x = D
	y = y + TILE_HEIGHT + D
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
		bitmap:setPosition(x, y)
		sprites:addChild(bitmap)
		--DEBUG("Bitmap", x, y, bitmap:getSize())
		x = x + TILE_WIDTH + D
	end

	x = D
	y = y + TILE_HEIGHT + D

	textures = {"Animal_01", "Animal_02", "Animal_03", "Archer_01", "Archer_02", "Archer_03", 
				"Assassin_01", "Assassin_02", "Assassin_03", "Barbarian_01", "Barbarian_02", "Barbarian_03", 
				"Gladiator_01", "Gladiator_03", "Ninja_01", "Ninja_02","Ninja_03", 
				"Samurai_01", "Samurai_02", "Samurai_03", "Troll_01", "Troll_02", "Troll_03"
				} 

	local clips = {}
	for i = 1, #textures do
		local mc = CharacterAnimation.new(textures[i])
		if not mc then break end
		mc:setPosition(x, y)
		mc:setScale(1)
		sprites:addChild(mc)
		table.insert(clips, mc)
		x = x + TILE_WIDTH + D
	end

	x = D
	y = y + TILE_HEIGHT + D

	for i = 1, #textures do
		local mc = CharacterAnimation.new(textures[i])
		if not mc then break end
		mc:setPosition(x, y)
		mc:setScale(2)
		sprites:addChild(mc)
		table.insert(clips, mc)
		x = x + 2 * (TILE_WIDTH + D)
		if i == 9 or i == 18 then
			x = D
			y = y + 2* (TILE_HEIGHT + D)
		end
	end
	
	self:addEventListener(Event.KEY_DOWN, function(event)
		local actions = {[KeyCode.I] = "IDLE", [KeyCode.W] = "WALK", [KeyCode.R] = "RUN", [KeyCode.J] = "JUMP", 
						[KeyCode.A] = "ATTACK", [KeyCode.NUM_1] = "ATTACK_01", [KeyCode.NUM_2] = "ATTACK_02", 
						[KeyCode.H] = "HURT", [KeyCode.D] = "DIE"}
		
		--DEBUG(event.keyCode, KeyCode.I, actions[KeyCode.I], actions[event.keyCode])

		for i = 1, #clips do
			DEBUG(i, event.keyCode, actions[event.keyCode])
			clips[i]:go(actions[event.keyCode])
		end		
	end)
	
	local commands = TextField.new(FONT_LARGE, "I W R J A 1 2 H D")
	commands:setPosition(800, 100)
	sprites:addChild(commands)
	
	self:addChild(sprites)
	
end	

