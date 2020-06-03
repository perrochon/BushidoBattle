--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2020 Louis Perrochon
]]

--[[
	Player and their attributes
--]]

Hero = Core.class(Character)

function Hero:init(entry, id)
	--[[Holding the player's stats
		entry = 1 for heroes. id is the slot [1..4]
	--]]

	ASSERT_EQUAL(self.entry, 1)    -- Heroes are 1, monsters are > 1
	ASSERT_TRUE(0 < id and id < 5, "Hero id not in 1..4. Value is "..id) -- [1..4]

	-- Overwrite some Character fields/logic
	self.name = self.info.names[self.id]
	-- We also overwrite self.sprite and self.mc in loadSprite() below
	self:loadSprite()
	--DEBUG(self.entry, self.id, self.name, self.sprite, self.xp, self.hp, self.see, self.alone)


	-- Additional Player fields
	self.active = false 
	self.kills = 0
	self.level = 1
	self.light = manual:getEntry("light-source", "torch")
	
	self.fileName = "|D|hero"..id


	-- TODO REFACTOR remove the rest...
	--self.tC = manual:getEntry("monsters",1).tC
	--self.tR = manual:getEntry("monsters",1).tR
	--self.tactics = "player"
	--self.x = 6
	--self.y = 6
	--self.blocked = true
	--self.xp = 0
	--self.hp = 600
	--self.maxHP = self.hp
	--self.bloodied = math.ceil(self.hp / 2)
	--self.HPbar = 0
	--prof is attack proficiency used by basicAttack
	--self.prof = 5
	--self.defense = {AC = 16, Fort = 16, Refl = 14, Will = 12}
	--equip the hero with a longsword for now
	--self.weapons = {}
	--self.weapons[1] = manual:getEntry("weapons", self.info.weapon1)
	--self.weapons[2] = manual:getEntry("weapons", self.info.weapon2)
	--self.weapon = self.weapons[1]
	--self.mc = CharacterAnimation.new(self.sprite)
	--self.mc.mc:gotoAndPlay(1)
	--self.mc:setPosition((self.x - 1) * TILE_WIDTH, (self.y - 1) * TILE_HEIGHT)
--[[
self.weapons = {{name = "shortsword", reach = 1, modifier = 8, defense = "AC", damage = 'd8', dice = 1, bonus = 6, 
						    type = "Physical", projectile = nil, missSound = "clang"},
					{name = "shortbow", reach = 5, modifier = 5, defense = "AC", damage = 'd6', dice = 1, bonus = 2,
					type = "Physical", projectile = "arrow", missSound = "swish"},
					}
	self.weapon = self.weapons[1]
]]
	-- resistances. vulnerabilities would be listed as negative (-5, etc..)
	--self.resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}
end

function Hero:loadSprite()
	self.sprite = self.info.sprites[self.id]
	--DEBUG(self.entry, self.id, self.name, self.sprite)
	self.mc = CharacterAnimation.new(self.sprite)
	self.mc.mc:gotoAndPlay(1)
	self.mc:setPosition((self.c - 1) * TILE_WIDTH, (self.r - 1) * TILE_HEIGHT)
end

function Hero:save()
	--DEBUG(self.name, self.fileName)
	local temp = self.mc
	self.mc = nil
	dataSaver.save(self.fileName, self)
	self.mc = temp
end

function Hero.load(id)
	local fileName = "|D|hero"..id
	local hero = dataSaver.load(fileName)
	hero.mc = CharacterAnimation.new(hero.sprite)
	hero.mc.mc:gotoAndPlay(1)
	--DEBUG("Resetting", hero.name, hero.fileName)
	heroes[id] = hero
end

function Hero.resetAllHeroes()
	for i=1, 4 do
		local hero = Hero.new(1,i) 
		--DEBUG("Resetting", hero.name, hero.fileName)
		hero:save()
		heroes[i] = hero
	end
end
