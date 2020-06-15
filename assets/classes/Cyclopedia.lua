--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2010 - 2020 Louis Perrochon
]]


--[[ TODO FIX move descriptions into structure below
	{name = "Animal_02", dx = -24, dy = 30}, -- Eagle "run"/"jump" look more like flying. It dies high up
	{name = "Animal_03", dx = -24, dy = 1}, -- Wolf
	{name = "Archer_01", dx = -50, dy = 5}, -- Masked Archer
	{name = "Archer_02", dx = -50, dy = 5}, -- Armored Crossbow Man
	{name = "Archer_03", dx = -50, dy = 4}, -- Robin Hood Archer
	{name = "Assassin_01", dx = 0, dy = 1}, -- Grey Assassin (two glove blades)
	{name = "Assassin_02", dx = 0, dy = 0}, -- White Assassin (knife)
	{name = "Assassin_03", dx = 0, dy = 1}, -- Dark Assassin (crossbow glove)
	{name = "Barbarian_01", dx = -8, dy = 7}, -- Ponytail Barbarian
	{name = "Barbarian_02", dx = -8, dy = 7}, -- Viking Barbarian
	{name = "Barbarian_03", dx = -8, dy = 7}, -- Blonde Barbarian double sword
	{name = "Gladiator_01", dx = -1, dy = 6}, -- Mohawk Gladiator with sword
	{name = "Gladiator_02", dx = -1, dy = 6}, -- Mohawk Gladiator with sword
	{name = "Gladiator_03", dx = -1, dy = 7}, -- Gladiator with flail (weapon that didn't exist...)
	{name = "Ninja_01", dx = -41, dy = 0}, -- Black Ninja Sword
	{name = "Ninja_02", dx = -41, dy = 0}, -- Blue Ninja two blades
	{name = "Ninja_03", dx = -41, dy = 0}, -- White Ninja one blade
	{name = "Samurai_01", dx = 0, dy = 5}, -- Peasant with Tachi (long sword)
	{name = "Samurai_02", dx = 0, dy = 5}, -- Samurai with Daisho (2 matching swords, Katana and Wakisashi)
	{name = "Samurai_02_green", dx = 0, dy = 5}, 
	{name = "Samurai_02_blue", dx = 0, dy = 5}, 
	{name = "Samurai_03", dx = 0, dy = 5}, -- Samurai with Odachi (long sword)
	{name = "Troll_01", dx = 3, dy = 0}, -- Green Troll with Club
	{name = "Troll_02", dx = 3, dy = 0}, -- Grey Troll with Hammer
	{name = "Troll_03", dx = 3, dy = 0}, -- Brown Troll with Club
--]]
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
			[4] = "loot",
			[5] = "light",
			},
		["light-source"] = {
			--[[
				0 - No change (i.e. it likely remains LIGHT_UNEXPLORED)
				1..3 - light up to LIGHT_BRIGHT, LIGHT_DIM, LIGHT_DARK
			--]]
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
		["light"] = {
			[LIGHT_BRIGHT] = {name = "bright", alpha = 0, cover = 0},
			[LIGHT_DIM] = {name = "dim", alpha = 0.4, cover = -1},
			[LIGHT_DARK] = {name = "dark/remembered", alpha = 0.6, cover = -2},
			[LIGHT_UNEXPLORED] = {name = "unexplored", alpha = 1, cover = -6},
			--[5] = {name = "white", alpha = 1, cover = -6},
			--[6] = {name = "black", alpha = 1, cover = -6},
			},
		["monsters"] = {
				--[[heor stats explained (where different from monster)
					name		display name
					xp 			collected xp of hero
				
					monster stats explained:
					-			currently not used
					xp			how much xp the hero gets for killing the monster
					hp			how many hp the character has
					bloodied	half the hp 
					AC			defense against physical attacks
					-Fort		their Fortitude stat
					-Will		their  Will stat
					-Refl		their  Reflex stat 
					-resist		all the resistances against types of magic (from Magic the Gathering)
					-attacks	simple monsters have one attack
					modifier	attack modifier
					defense		which defense is being attacked
					dice, damage, bonus = 1d6+2 = 1, d6, 2
					tactics		behavior, "minion" or "soldier" for monsters, "player" for hero
					see			how far monsters can see
					alone  		how far other monsters need to be for this monster to feel alone
					
					weapon stats explained:
					reach		how far away they can hit
					type		nil is physical damage, the others could be green, red, blue, white or black
					projectile	the projectile animation used for the attack, either spear, arrow or magic
					missSound   what the program reports for close misses
				--]]
			texturePack = "images/characters.png",
			textureIndex = "images/characters.txt",
			[1] = {entry = 1, name = "hero", 
					names = {"Ninja One", "Ninja Two", "Ninja Three", "Ninja Four", "TODO DELETE ME",},
					sprites = {"Ninja_01", "Ninja_02", "Ninja_03", "Assassin_01",}, dx = -41, dy = -0, scale = 1,
					xp = 0, hp = 600, 
					defense = {AC = 16, Fort = 16, Refl = 14, Will = 12},
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "shortsword", weapon2 = "shortbow", 
					tactics = "player", see = 0, alone = 0
					},
			[5] = {entry = 5, name = "bear", sprite = "Animal_01", dx = -24, dy = 10, scale = 1.3,
					xp = 4, drop = "mon", hp = 50, 
					defense = {AC = 14, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "claw", weapon2 = "fang", 
					tactics = "soldier", see = 6, alone = 4
					},
			[6] = {entry = 6, name = "eagle", sprite = "Animal_02", dx = -24, dy = 30, scale = 1,
					xp = 2, drop = "mon", hp = 25, 
					defense = {AC = 14, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "claw", weapon2 = "fang", 
					tactics = "minion", see = 6, alone = 4
					},
			[7] = {entry = 7, name = "wolf", sprite = "Animal_03", dx = -24, dy = 1, scale = 1,
					xp = 2, drop = "mon", hp = 25, 
					defense = {AC = 14, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "claw", weapon2 = "fang", 
					tactics = "minion", see = 6, alone = 4
					},
			[19] = {entry = 19, name = "archer", sprite = "Archer_01", dx = -55, dy = 5, scale = 1,
					xp = 4, drop = "mon", hp = 50, 
					defense = {AC = 16, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 1, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "knife", weapon2 = "shortbow", 
					tactics = "minion", see = 6, alone = 4
					},
			[20] = {entry = 20, name = "archer", sprite = "Archer_02", dx = -55, dy = 5, scale = 1,
					xp = 4, drop = "mon", hp = 50, 
					defense = {AC = 16, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 1, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "knife", weapon2 = "shortbow", 
					tactics = "minion", see = 6, alone = 4
					},
			[21] = {entry = 21, name = "archer", sprite = "Archer_03", dx = -55, dy = 5, scale = 1,
					xp = 4, drop = "mon", hp = 50, 
					defense = {AC = 16, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 1, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "knife", weapon2 = "shortbow", 
					tactics = "minion", see = 6, alone = 4
					},
			[22] = {entry = 22, name = "assassin", sprite = "Assassin_01", dx = -5, dy = 5, scale = 1,
					xp = 4, drop = "mon", hp = 50, 
					defense = {AC = 16, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 1, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "knife", weapon2 = "shortbow", 
					tactics = "minion", see = 6, alone = 4
					},
			[23] = {entry = 23, name = "assassin", sprite = "Assassin_02", dx = -5, dy = 5, scale = 1,
					xp = 4, drop = "mon", hp = 50, 
					defense = {AC = 16, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 1, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "knife", weapon2 = "shortbow", 
					tactics = "minion", see = 6, alone = 4
					},
			[24] = {entry = 24, name = "assassin", sprite = "Assassin_03", dx = -5, dy = 5, scale = 1,
					xp = 4, drop = "mon", hp = 50, 
					defense = {AC = 16, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 1, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "knife", weapon2 = "shortbow", 
					tactics = "minion", see = 6, alone = 4
					},
			[8] = {entry = 8, name = "barbarian", sprite = "Barbarian_01", dx = -8, dy = 7, scale = 1,
					xp = 2, drop = "mon", hp = 15, 
					defense = {AC = 14, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "sword", weapon2 = nil, 
					tactics = "minion", see = 6, alone = 4
					},
			[9] = {entry = 9, name = "barbarian", sprite = "Barbarian_02", dx = -8, dy = 7, scale = 1,
					xp = 2, drop = "mon", hp = 15, 
					defense = {AC = 14, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "sword", weapon2 = nil, 
					tactics = "minion", see = 6, alone = 4
					},
			[10] = {entry = 10, name = "barbarian", sprite = "Barbarian_03", dx = -8, dy = 7, scale = 1,
					xp = 2, drop = "mon", hp = 15, 
					defense = {AC = 14, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "sword", weapon2 = nil, 
					tactics = "minion", see = 6, alone = 4
					},
			[11] = {entry = 11, name = "barbarian", sprite = "Gladiator_01", dx = -1, dy = 6, scale = 1,
					xp = 2, drop = "mon", hp = 15, 
					defense = {AC = 14, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "sword", weapon2 = nil, 
					tactics = "minion", see = 6, alone = 4
					},
			[12] = {entry = 12, name = "barbarian", sprite = "Gladiator_02", dx = -1, dy = 6, scale = 1,
					xp = 2, drop = "mon", hp = 15, 
					defense = {AC = 14, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "axe", weapon2 = nil, 
					tactics = "minion", see = 6, alone = 4
					},
			[13] = {entry = 13, name = "barbarian", sprite = "Gladiator_03", dx = -1, dy = 7, scale = 1,
					xp = 2, drop = "mon", hp = 15, 
					defense = {AC = 14, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "flail", weapon2 = nil, 
					tactics = "minion", see = 6, alone = 4
					},
			[25] = {entry = 25, name = "ninja", sprite = "Ninja_01", dx = -40, dy = 0, scale = 1,
					xp = 4, drop = "mon", hp = 50, 
					defense = {AC = 16, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 1, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "knife", weapon2 = "shortbow", 
					tactics = "minion", see = 6, alone = 4
					},
			[26] = {entry = 26, name = "ninja", sprite = "Ninja_02", dx = -40, dy = 0, scale = 1,
					xp = 4, drop = "mon", hp = 50, 
					defense = {AC = 16, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 1, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "knife", weapon2 = "shortbow", 
					tactics = "minion", see = 6, alone = 4
					},
			[27] = {entry = 27, name = "ninja", sprite = "Ninja_03", dx = -40, dy = 0, scale = 1,
					xp = 4, drop = "mon", hp = 50, 
					defense = {AC = 16, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 1, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "knife", weapon2 = "shortbow", 
					tactics = "minion", see = 6, alone = 4
					},
			[2] = {entry = 2, name = "peasant", sprite = "Samurai_01", dx = 0, dy = 5, scale = 1,
					xp = 1, drop = "mon", hp = 4, 
					defense = {AC = 10, Fort = 12, Refl = 14, Will = 11}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "stick", weapon2 = nil, 
					tactics = "minion", see = 4, alone = 5
					},
			[4] = {entry = 4, name = "samurai", sprite = "Samurai_02", dx = 0, dy = 5, scale = 1,
					xp = 4, drop = "bu", hp = 25, 
					defense = {AC = 14, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "katana", weapon2 = "spear", 
					tactics = "soldier", see = 3, alone = 100
					},
			[14] = {entry = 14, name = "samurai", sprite = "Samurai_02_blue", dx = 0, dy = 5, scale = 1,
					xp = 4, drop = "bu", hp = 25, 
					defense = {AC = 14, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "katana", weapon2 = "spear", 
					tactics = "soldier", see = 3, alone = 100
					},
			[15] = {entry = 15, name = "samurai", sprite = "Samurai_02_green", dx = 0, dy = 5, scale = 1,
					xp = 4, drop = "bu", hp = 25, 
					defense = {AC = 14, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "katana", weapon2 = "spear", 
					tactics = "soldier", see = 3, alone = 100
					},
			[3] = {entry = 3, name = "soldier", sprite = "Samurai_03", dx = 0, dy = 5, scale = 1,
					xp = 3, drop = "shu", hp = 15,   
					defense = {AC = 12, Fort = 13, Refl = 15, Will = 12}, prof = 0,
					resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "shortsword", weapon2 = "javelin", 
					tactics = "soldier", see = 6, alone = 10
					},
			[16] = {entry = 16, name = "troll", sprite = "Troll_01", dx = 3, dy = 10, scale = 1.8,
					xp = 4, drop = "shu", hp = 50, 
					defense = {AC = 16, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 1, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "club", weapon2 = nil, 
					tactics = "minion", see = 6, alone = 4
					},
			[17] = {entry = 17, name = "troll", sprite = "Troll_02", dx = 3, dy = 10, scale = 1.8,
					xp = 4, drop = "shu", hp = 50, 
					defense = {AC = 16, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 1, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "club", weapon2 = nil, 
					tactics = "minion", see = 6, alone = 4
					},
			[18] = {entry = 18, name = "troll", sprite = "Troll_03", dx = 3, dy = 10, scale = 1.8,
					xp = 4, drop = "shu", hp = 50, 
					defense = {AC = 16, Fort = 17, Refl = 15, Will = 13}, prof = 0,
					resist = {Physical = 1, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}, 
					weapon1 = "club", weapon2 = nil, 
					tactics = "minion", see = 6, alone = 4
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
			[9] = {name = "beak", reach = 1.5, modifier = 2, defense = "AC", damage = 'd6', dice = 1, bonus = 2,
							type = "Physical", projectile = nil, missSound = "swish"},
			[10] = {name = "sword", reach = 1.5, modifier = 5, defense = "AC", damage = 'd6', dice = 1, bonus = 2, 
						    type = "Physical", projectile = nil, missSound = "clang"},
			[11] = {name = "axe", reach = 1.5, modifier = 5, defense = "AC", damage = 'd6', dice = 1, bonus = 2, 
						    type = "Physical", projectile = nil, missSound = "clang"},
			[12] = {name = "flail", reach = 2.5, modifier = 6, defense = "AC", damage = 'd6', dice = 1, bonus = 2, 
						    type = "Physical", projectile = nil, missSound = "clang"},
			[13] = {name = "club", reach = 1.5, modifier = 3, defense = "AC", damage = 'd4', dice = 1, bonus = 3, 
						    type = "Physical", projectile = nil, missSound = "clang"},
			[14] = {name = "knife", reach = 1.5, modifier = 6, defense = "AC", damage = 'd10', dice = 1, bonus = 5, 
						    type = "Physical", projectile = nil, missSound = "clang"},
			},
		["projectiles"] = {
			[1] = {name = "arrow", image = TextureRegion.new(projectilesTexture, 0, 0, 108, 108), speed = 5},
			[2] = {name = "spear", image = TextureRegion.new(projectilesTexture, 108, 0, 108, 108), speed = 5},
			[3] = {name = "fireball", image = TextureRegion.new(projectilesTexture, 216, 0, 108, 108), speed = 5},
			[4] = {name = "hammer", image = TextureRegion.new(projectilesTexture, 324, 0, 108, 108), speed = 5},
			},
		["loot"] = {
			texturePack = "images/loot.png",
			textureIndex = "images/loot.txt",
			-- Amulets: Omamori, blue Kanai-Anzen (protects), purple kaiun (luck), green yaku-yoke (avoid evil)
			[1] = {name = "mon", sprite = "6.png", value = 1,},
			[2] = {name = "shu", sprite = "7.png", value = 6,},
			[3] = {name = "bu", sprite = "8.png", value = 72,},
			[4] = {name = "ryo", sprite = "9.png", value = 1728,},
			[5] = {name = "yen", sprite = "10.png", value = 12096,},
			[6] = {name = "red omamori", sprite = "1.png", value = 500,},
			[7] = {name = "yaku-yoke", sprite = "2.png", value = 500,},
			[8] = {name = "yellow omamori", sprite = "3.png", value = 500,},
			[9] = {name = "kanai-anzen", sprite = "4.png", value = 500,},
			[10] = {name = "kaiun", sprite = "5.png", value = 500,},
			},
		["bars"] = {},
			-- health bars are generated in loadSprites()
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
				return val, key
			end
		end
	end
end

function Cyclopedia:loadSprites()

	-- TODO FIX LOOT TODO FIX ANIMATION plenty of lines here should go away, don't need Monster bitmaps
	-- Characters
	local texturePack = self.lists["monsters"].texturePack
	local textureIndex = self.lists["monsters"].textureIndex
	--INFO("Character Pack:", texturePack, "Character Index:", textureIndex)
	self.lists["monsters"].pack = TexturePack.new(textureIndex, texturePack)

	-- TODO FIX ANIMATION remove deprecatedTextureNames
	
	for key, value in ipairs(self.lists["monsters"]) do

		if not value.deprecatedName then value.deprecatedName = "Samurai_01__WALK_000.png" end

		--INFO("  ", value.name, value.deprecatedName)
		local region = self.lists["monsters"].pack:getTextureRegion(value.deprecatedName)
		local tX, tY, w, h = region:getRegion()
		value.tC = tX/TILE_WIDTH+1
		value.tR = tY/TILE_HEIGHT+1
		--DEBUG("  ", key, value.name, value.tC, value.tR, tX, tY, w, h, value.deprecatedName)		
	end

	-- TODO FIX LOOT TODO FIX ANIMATION until here

	-- Load Loot
	local texturePack = self.lists["loot"].texturePack
	local textureIndex = self.lists["loot"].textureIndex
	--INFO("Character Pack:", texturePack, "Character Index:", textureIndex)
	self.lists["loot"].pack = TexturePack.new(textureIndex, texturePack)

	-- Generate Health Bars
	local STEPS = 10 -- 0 plus 10 steps of bar
	local D = 2 -- border width
	local H = 5 -- height of health bar

	for k,v in pairs(self.lists["bars"]) do DEBUG("Cyclopedia", #self.lists["bars"], k,v) end

	for s = 1, STEPS do
		local rt = RenderTarget.new(TILE_WIDTH, TILE_HEIGHT)
		local w = math.floor((s / STEPS) * (TILE_WIDTH - 4 * D))
		local r = math.floor(s / STEPS * 127) + 128
		local g = math.floor((STEPS - s) / STEPS * 63)
		local b = math.floor((STEPS - s) / STEPS * 63)
		local color = ((r*256)+g)*256+b
		local alpha = (s / STEPS * 0.5) + 0.5

		local frame = Pixel.new(COLOR_BLACK, alpha, TILE_WIDTH - 2 * D, H + 2 * D)
		frame:setPosition(D, TILE_HEIGHT - H - 3 * D)
		rt:draw(frame)
		
		local bar = Pixel.new(color, alpha, w, H)
		bar:setPosition(2 * D , TILE_HEIGHT - H - 2 * D)
		rt:draw(bar)
		table.insert(self.lists["bars"], rt)	-- TODO LOOT need to fix positions above, and make rt inside loop
	end
	
	-- Light
	local STEPS = 4 -- 4 levels of light, ignore first (zero) tile.

	local rt = RenderTarget.new(STEPS * TILE_WIDTH, TILE_HEIGHT )
	local bitmap = Bitmap.new(rt)

	for s = 1, STEPS do
		local lightLevel = self:getEntry("light", s)
		local shadow = Pixel.new(COLOR_LTBLACK, lightLevel.alpha, TILE_WIDTH, TILE_HEIGHT)
		shadow:setPosition((s-1)*TILE_WIDTH, 0)
		rt:draw(shadow)
	end
	self.lists[self:getEntry("layers", LAYER_LIGHT)].pack = rt
	
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