--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2020 Louis Perrochon
]]

--[[
	Player and their attributes
--]]

Player = Core.class(Character)

function Player:init(entry, id)
	--[[Holding the player's stats
		entry = 1 for heroes. id is the slot [1..4]
	--]]

	ASSERT_EQUAL(self.entry, 1)    -- Heroes are 1, monsters are > 1
	ASSERT_TRUE(0 > id and id < 5) -- [1..4]

	-- Overwrite some Character fields/logic
	self.name = self.info.names[self.id]
	-- We also overwrite self.sprite and self.mc in loadSprite() below
	self:loadSprite()
	DEBUG(self.entry, self.id, self.name, self.sprite, self.xp, self.hp, self.see, self.alone)


	-- Additional Player fields
	self.kills = 0
	self.level = 1
	self.light = manual:getEntry("light-source", "torch")


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

function Player:loadSprite()
	self.sprite = self.info.sprites[self.id]
	DEBUG(self.entry, self.id, self.name, self.sprite)
	self.mc = CharacterAnimation.new(self.sprite)
	self.mc.mc:gotoAndPlay(1)
	self.mc:setPosition((self.x - 1) * TILE_WIDTH, (self.y - 1) * TILE_HEIGHT)
end

function Player:save(filename)
	DEBUG(self.name, filename, currenHeroFileName)
	local temp = self.mc
	self.mc = nil
	dataSaver.save(filename, self)
	self.mc = temp
end

function Player.load(filename)
	local hero = dataSaver.load(filename)
	hero.mc = CharacterAnimation.new(hero.sprite)
	hero.mc.mc:gotoAndPlay(1)
	hero.mc:setPosition((hero.x - 1) * TILE_WIDTH, (hero.y - 1) * TILE_HEIGHT)
	return hero
end

