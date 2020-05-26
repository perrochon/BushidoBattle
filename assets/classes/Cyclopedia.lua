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
		["terrainDEPRECATED"] = {
			[1] = {id = -1, name = "1 patch of grass", texture = "Dungeon_Floor_2x2.png"},
			[2] = {id = -2, name = "1 road", texture = "Dungeon_Floor_2x2.png"},
			[3] = {id = -3, name = "1 creek", texture = "Dungeon_Floor_2x2.png"},
			[4] = {id = -4, name = "1 thing", texture = "Dungeon_Floor_2x2.png"},
			},
		["environmentDEPRECATED"] = {
			[1] = {id = -5, name = "2 forest", blocked = true, cover = -6, texture = "Tree_Crown_06.png"},
			[2] = {id = -6, name = "2 forest", blocked = true, cover = -6, texture = "Tree_Crown_07.png"},
			[3] = {id = -7, name = "2 new tree", blocked = true, cover = -2, texture = "Tree_Crown_01.png"},
			[4] = {id = -8, name = "2 tree", blocked = true, cover = -4, texture = "Tree_Crown_02.png"},
			[5] = {id = -9, name = "2 new rock", blocked = true, cover = 0, texture = "Light_Moss_Rough_Well_2x2_B.png"},
			[6] = {id = -10, name = "2 rock", blocked = false, cover = -2, texture = "Light_Moss_Rough_Well_2x2_B.png"},
			},
		["light-source"] = {
			[1] = {name = "torch", radius = 3, array = {
						0, 0, 2, 1, 2, 0, 0, 
						0, 1, 1, 1, 1, 1, 0, 
						2, 1, 1, 1, 1, 1, 2, 
						1, 1, 1, 1, 1, 1, 1, 
						2, 1, 1, 1, 1, 1, 2, 
						0, 1, 1, 1, 1, 1, 0, 
						0, 0, 2, 1, 2, 0, 0}},
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
		["light"] = {
			[1] = {name = "bright", cover = 0},
			[2] = {name = "dim", cover = -1},
			[3] = {name = "dark/remembered", cover = -2},
			[4] = {name = "unexplored", cover = -6},
			[5] = {name = "white", cover = -6},
			[6] = {name = "black", cover = -6},
			},
		["monsters"] = {
			texturePack = "images/characters.png",
			textureIndex = "images/characters.txt",
			[1] = {name = "hero", weapon1 = "shortsword", weapon2 = "shortbow", textureName = "Ninja_02__WALK_000.png"},
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
			[3] = {name = "shortsword", reach = 1.5, modifier = 4, defense = "AC", damage = 'd2', dice = 1, bonus = 0, 
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

	local texturePack = self.lists["monsters"].texturePack
	local textureIndex = self.lists["monsters"].textureIndex
	INFO("Character Pack:", texturePack, "Character Index:", textureIndex)
	self.lists["monsters"].pack = TexturePack.new(textureIndex, texturePack)

	for key, value in ipairs(self.lists["monsters"]) do
		--INFO("  ", value.name, value.textureName)
		local region = self.lists["monsters"].pack:getTextureRegion(value.textureName)
		local tX, tY, w, h = region:getRegion()
		value.tC = tX/108+1
		value.tR = tY/108+1
		--DEBUG("  ", key, value.name, value.tC, value.tR, tX, tY, w, h, value.textureName)		
	end
	
end