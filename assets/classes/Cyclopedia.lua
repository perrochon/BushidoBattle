--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2010 - 2020 Louis Perrochon
]]

-- The layer lookup "table"
Cyclopedia = Core.class()

function Cyclopedia:init()

	local projectilesTexture = Texture.new("images/texturepack-projectiles-108px.png", true)

	--the manuals and lists. 
	--make sure the numbers here match up with their positions in the tileset images.
	local manual = {
		["layers"] = {
			[1] = "terrain",
			[2] = "environment",
			[3] = "monsters",
			[4] = "health",
			[5] = "light",
			},
		["light-source"] = {
			[1] = {name = "torch", radius = 3, array = {
						0, 3, 2, 1, 2, 3, 0, 
						3, 2, 1, 1, 1, 2, 3, 
						2, 1, 1, 1, 1, 1, 2, 
						1, 1, 1, 1, 1, 1, 1, 
						2, 1, 1, 1, 1, 1, 2, 
						3, 2, 1, 1, 1, 2, 3, 
						0, 3, 2, 1, 2, 3, 0}},
			[2] = {name = "daylight", radius = 4, array = {
						2, 1, 1, 1, 1, 1, 1, 1, 2, 
						1, 1, 1, 1, 1, 1, 1, 1, 1,
						1, 1, 1, 1, 1, 1, 1, 1, 1,
						1, 1, 1, 1, 1, 1, 1, 1, 1,
						1, 1, 1, 1, 1, 1, 1, 1, 1,
						1, 1, 1, 1, 1, 1, 1, 1, 1,
						1, 1, 1, 1, 1, 1, 1, 1, 1,
						1, 1, 1, 1, 1, 1, 1, 1, 1,
						2, 1, 1, 1, 1, 1, 1, 1, 2}},
			},
		["health"] = {},
		["light"] = {
			[1] = {name = "bright", alpha = 0, cover = 0},
			[2] = {name = "dim", alpha = 0.4, cover = -1},
			[3] = {name = "dark/remembered", alpha = 0.6, cover = -2},
			[4] = {name = "unexplored", alpha = 1, cover = -6},
			--[5] = {name = "white", alpha = 1, cover = -6},
			--[6] = {name = "black", alpha = 1, cover = -6},
			},
		["monsters"] = {
			texturePack = "images/characters.png",
			textureIndex = "images/characters.txt",
			[1] = {name = "hero", weapon1 = "shortsword", weapon2 = "shortbow", textureName = "Samurai_02__WALK_000_BLUE.png"},
				--[[monster stats explained:
					xp			how much xp the hero gets
					hp			how many hp the monster has
					bloodied	half the hp 
					AC			defense against physical attacks
					Fort		their Fortitude stat
					Will		their  Will stat
					Refl		their  Reflex stat 
					resist		all the resistances against types of magic (from Magic the Gathering)
					attacks		simple monsters have one attack
					reach		how many squares away to hitTestPoint
					modifier	attack modifier
					defense		which defense is being attacked
					dice, damage, bonus = 1d6+2 = 1, d6, 2
					tactics		behavior, "minion" or "soldier". Minions flee when bloodied or alone.
					see			how far monsters can see
					alone  		how far other monsters need to be for this monster to feel alone
					type		nil is physical damage, the others could be green, red, blue, white or black
					projectile	the projectile animation used for the attack, either spear, arrow or magic
					missSound   what the program reports for close misses
					--]]
			[2] = {name = "peasant", textureName = "Samurai_01__WALK_000.png", xp = 1, hp = 4, bloodied = 2, 
					defense = {AC = 10, Fort = 12, Refl = 14, Will = 11}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "stick", weapon2 = nil, tactics = "minion", see = 4, alone = 5
					},
			[3] = {name = "soldier", textureName = "Samurai_03__WALK_000.png", xp = 3, hp = 15, bloodied = 7,  
					defense = {AC = 12, Fort = 13, Refl = 15, Will = 12}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "shortsword", weapon2 = "javelin", tactics = "soldier", see = 6, alone = 10
					},
			[4] = {name = "samurai", textureName = "Samurai_02__WALK_000.png", xp = 4, hp = 25, bloodied = 12, 
					defense = {AC = 14, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "katana", weapon2 = "spear", tactics = "soldier", see = 3, alone = 100
					},
			[5] = {name = "wolf", textureName = "Animal_03__WALK_000.png", xp = 2, hp = 25, bloodied = 12, 
					defense = {AC = 14, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "claw", weapon2 = "fang", tactics = "minion", see = 6, alone = 4
					},
			},
		["weapons"] = {
			[1] = {name = "katana", reach = 1.5, modifier = 6, defense = "AC", damage = 'd10', dice = 1, bonus = 5, 
						    type = "Physical", projectile = nil, missSound = "clang"},
			[2] = {name = "spear", reach = 2.5, modifier = 8, defense = "AC", damage = 'd6', dice = 1, bonus = 2, 
						    type = "Physical", projectile = "spear", missSound = "swish"},
			[3] = {name = "shortsword", reach = 1.5, modifier = 4, defense = "AC", damage = 'd6', dice = 1, bonus = 2, 
						    type = "Physical", projectile = nil, missSound = "clang"},
			[4] = {name = "javelin", reach = 4, modifier = 6, defense = "AC", damage = 'd8', dice = 1, bonus = 2, 
						    type = "Physical", projectile = "spear", missSound = "swish"},
			[5] = {name = "stick", reach = 1.5, modifier = 2, defense = "AC", damage = 'd4', dice = 1, bonus = 3, 
						    type = "Physical", projectile = nil, missSound = "clang"},
			[6] = {name = "shortbow", reach = 5, modifier = 5, defense = "AC", damage = 'd6', dice = 1, bonus = 2,
							type = "Physical", projectile = "arrow", missSound = "swish"},
			[7] = {name = "claw", reach = 1.5, modifier = 2, defense = "AC", damage = 'd6', dice = 1, bonus = 2,
							type = "Physical", projectile = nil, missSound = "swish"},
			[8] = {name = "fang", reach = 1.5, modifier = 2, defense = "AC", damage = 'd6', dice = 1, bonus = 2,
							type = "Physical", projectile = nil, missSound = "swish"},
			},
		["projectiles"] = {
			[1] = {name = "arrow", image = TextureRegion.new(projectilesTexture, 0, 0, 108, 108), speed = 5},
			[2] = {name = "spear", image = TextureRegion.new(projectilesTexture, 108, 0, 108, 108), speed = 5},
			[3] = {name = "fireball", image = TextureRegion.new(projectilesTexture, 216, 0, 108, 108), speed = 5},
			[4] = {name = "hammer", image = TextureRegion.new(projectilesTexture, 324, 0, 108, 108), speed = 5},
			},
		}
	self.lists = {}
	for key, val in pairs(manual) do
		self.lists[key] = val
	end
	self:loadSprites()
end

--get value for specific manual
function Cyclopedia:getEntry(list, entry)
	local cyclopedia = self.lists[list]
	local isNumber = tonumber(entry)
	if isNumber then
		return cyclopedia[entry]
	else
		for key, val in pairs(cyclopedia) do
			if val.name == entry then
				return val
			end
		end
	end
end

function Cyclopedia:loadSprites()

	-- Characters
	local texturePack = self.lists["monsters"].texturePack
	local textureIndex = self.lists["monsters"].textureIndex
	INFO("Character Pack:", texturePack, "Character Index:", textureIndex)
	self.lists["monsters"].pack = TexturePack.new(textureIndex, texturePack)

	for key, value in ipairs(self.lists["monsters"]) do
		--INFO("  ", value.name, value.textureName)
		local region = self.lists["monsters"].pack:getTextureRegion(value.textureName)
		local tX, tY, w, h = region:getRegion()
		value.tC = tX/TILE_WIDTH+1
		value.tR = tY/TILE_HEIGHT+1
		DEBUG("  ", key, value.name, value.tC, value.tR, tX, tY, w, h, value.textureName)		
	end

	-- Health Bars
	local STEPS = 10 -- 0 plus 10 steps of bar
	local D = 2 -- border width
	local H = 5 -- height of health bar

	local rt = RenderTarget.new((STEPS + 1) * TILE_WIDTH, TILE_HEIGHT )
	local bitmap = Bitmap.new(rt)

	-- first tile (full health) is clear.
	for s = 1, STEPS do
		local x = s * TILE_WIDTH
		local w = math.floor((s / STEPS) * (TILE_WIDTH - 4 * D))
		local r = math.floor(s / STEPS * 127) + 128
		local g = math.floor((STEPS - s) / STEPS * 63)
		local b = math.floor((STEPS - s) / STEPS * 63)
		local color = ((r*256)+g)*256+b
		local alpha = (s / STEPS * 0.5) + 0.5

		local frame = Pixel.new(COLOR_BLACK, alpha, TILE_WIDTH - 2 * D, H + 2 * D)
		frame:setPosition(x + D, TILE_HEIGHT - H - 3 * D)
		rt:draw(frame)
		
		local bar = Pixel.new(color, alpha, w, H)
		bar:setPosition(x + 2 * D , TILE_HEIGHT - H - 2 * D)
		rt:draw(bar)		
	end
	self.lists[self:getEntry("layers", LAYER_HP)].pack = rt

	-- Light
	local STEPS = 4 -- 4 levels of light, ignore first (zero) tile.

	local rt = RenderTarget.new(STEPS * TILE_WIDTH, TILE_HEIGHT )
	local bitmap = Bitmap.new(rt)

	-- first tile (full health) is clear.
	for s = 1, STEPS do
		local lightLevel = self:getEntry("light", s)
		local shadow = Pixel.new(COLOR_LTBLACK, lightLevel.alpha, TILE_WIDTH, TILE_HEIGHT)
		shadow:setPosition((s-1)*TILE_WIDTH, 0)
		rt:draw(shadow)
	end
	self.lists[self:getEntry("layers", LAYER_LIGHT)].pack = rt
	
end

function Cyclopedia:displayAllSprites()
	-- Call this at the end of main when debugging issues with sprite loading

	local ROWS = 3
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
	for key, value in ipairs(self.lists["monsters"]) do
		local bitmap = self:getSprite(LAYER_MONSTERS, value.textureName)
		sprites:addChild(bitmap)
		bitmap:setPosition(x, y)
		x = x + TILE_WIDTH + D
	end

	-- Draw Light Shadows
	x = D
	y = y + TILE_HEIGHT + D
	local pack = self.lists["light"].pack
	for i = 0, 5 do
		local bitmap = self:getSprite(LAYER_LIGHT, i)
		bitmap:setPosition(x, y)
		sprites:addChild(bitmap)
		--DEBUG("Bitmap", x, y, bitmap:getSize())
		x = x + TILE_WIDTH + D
	end

	-- Draw Health Bars
	x = x + D
	local pack = self.lists["health"].pack
	for i = 0, 10 do
		local bitmap = self:getSprite(LAYER_HP, i)
		bitmap:setPosition(x, y)
		sprites:addChild(bitmap)
		--DEBUG("Bitmap", x, y, bitmap:getSize())
		x = x + TILE_WIDTH + D
	end

	x = D
	y = y + TILE_HEIGHT + D

	local n1 = CharacterAnimation.new("Ninja_01")
	n1:setPosition(x-10, y-10)
	n1:setScale(1.2)
	sprites:addChild(n1)

	x = x + TILE_WIDTH + D
	local n2 = CharacterAnimation.new("Ninja_02")
	n2:setPosition(x-18, y-18)
	n2:setScale(1.3)
	sprites:addChild(n2)

	x = x + TILE_WIDTH + D
	local n3 = CharacterAnimation.new("Ninja_03")
	n3:setPosition(x-20, y-20)
	n3:setScale(1.4)
	sprites:addChild(n3)
	
	local on = true
	
	sprites:addEventListener(Event.KEY_DOWN, function(event)
		local actions = {[KeyCode.I] = "IDLE", [KeyCode.W] = "WALK", [KeyCode.R] = "RUN", [KeyCode.J] = "JUMP", 
						[KeyCode.A] = "ATTACK_01", [KeyCode.B] = "ATTACK_02", [KeyCode.H] = "HURT", [KeyCode.D] = "DIE"}
		
		--DEBUG(event.keyCode, KeyCode.I, actions[KeyCode.I], actions[event.keyCode])
		n1:go(actions[event.keyCode])
		n2:go(actions[event.keyCode])
		n3:go(actions[event.keyCode])
		if event.keyCode == KeyCode.E then
			n1:walk()
			n2:walk()
			n3:walk()
		end
	end)
	
	return sprites
	
end

function Cyclopedia:getSprite(layerNumber, which)
	local pack = self.lists[self:getEntry("layers", layerNumber)].pack

	local region = {}
	if tonumber(which) then
		region = TextureRegion.new(pack, TILE_WIDTH * which, 0 , TILE_WIDTH, TILE_HEIGHT)
	else
		region = pack:getTextureRegion(which)
	end

	return Bitmap.new(region)
end
