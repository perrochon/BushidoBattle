--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2020 Louis Perrochon
]]

--[[
	Player and their attributes
--]]

Player = Core.class()

function Player:init(subEntry)
	--[[Holding the player's stats
		entry is the monster # that is created and used in the manual and in the tileset
		entry = 1 for hero
	--]]

	self.subentry = subEntry -- position in Hero selection and file name for stored/reset heroes
	self.entry = 1 	--position/key in tileset-monsters and monster array. HEROFIX all heroes are the same (for now)
	self.heroIdx = -1 -- position in ScenePlay.heroes
	self.flip = 0 -- don't flip the icon 

	names = {"ArcherYP", "YummySake", "Lupus", "Kiga", "Remote San"}
	self.name = names[subEntry]
	
	DEBUG("hero tC", manual:getEntry("monsters",1).tC)
	self.tC = manual:getEntry("monsters",1).tC
	self.tR = manual:getEntry("monsters",1).tR

	local info = manual:getEntry("monsters", self.entry)	
	if subEntry == 5 then flip = TileMap.FLIP_HORIZONTAL end -- HEROFIX temporarily, we flip the remote hero.
	
	self.tactics = "player"
	self.x = 6
	self.y = 6
	self.light = manual:getEntry("light-source", "torch")
	self.blocked = true
	
	self.xp = 0
	self.hp = 600
	self.maxHP = self.hp
	self.bloodied = math.ceil(self.hp / 2)
	self.HPbar = 0
	
	self.kills = 0
	self.level = 1

	--prof is attack proficiency used by basicAttack
	self.prof = 5
	self.defense = {AC = 16, Fort = 16, Refl = 14, Will = 12}
	--equip the hero with a longsword for now
	self.weapons = {}
	self.weapons[1] = manual:getEntry("weapons", info.weapon1)
	self.weapons[2] = manual:getEntry("weapons", info.weapon2)
	self.weapon = self.weapons[1]
	
	self.mc = CharacterAnimation.new("Ninja_02")
	self.mc.mc:gotoAndPlay(1)
	self.mc:setPosition((self.x - 1) * TILE_WIDTH, (self.y - 1) * TILE_HEIGHT)

--[[
self.weapons = {{name = "shortsword", reach = 1, modifier = 8, defense = "AC", damage = 'd8', dice = 1, bonus = 6, 
						    type = "Physical", projectile = nil, missSound = "clang"},
					{name = "shortbow", reach = 5, modifier = 5, defense = "AC", damage = 'd6', dice = 1, bonus = 2,
					type = "Physical", projectile = "arrow", missSound = "swish"},
					}
	self.weapon = self.weapons[1]
]]

	-- resistances. vulnerabilities would be listed as negative (-5, etc..)
	self.resist = {Physical = 0, Green = 0, Red = 0, Blue = 0, White = 0, Black = 0}
end

function Player:save(filename)
	local mc = self.mc
	self.mc = nil
	dataSaver.save(filename, self)
	self.mc = mc
end

function Player.load(filename)
	local hero = dataSaver.load(filename)
	hero.mc = CharacterAnimation.new("Ninja_02")
	hero.mc.mc:gotoAndPlay(1)
	hero.mc:setPosition((hero.x - 1) * TILE_WIDTH, (hero.y - 1) * TILE_HEIGHT)
	return hero
end

function Player:setHealth(health)
	self.hp = health
	self.HPbar = 10 - math.floor((self.hp / self.maxHP) * 10)
	self.mc:setHealth(self.HPbar)
end

function Player:setPosition(c, r)
	self.x = c
	self.y = r
	self.mc:setPosition((self.x - 1) * TILE_WIDTH, (self.y - 1) * TILE_HEIGHT)
end

function Player:moveTo(c, r)

	self.x = c
	self.y = r

	local animate = {}
	animate.x = (self.x - 1) * TILE_WIDTH
	animate.y = (self.y - 1) * TILE_HEIGHT
	local properties = {}
	properties.delay = 0
	properties.dispatchEvents = false
	
	self.mc:walk()

 	local tween = GTween.new(self.mc, MOVE_SPEED, animate, properties)
	
	return tween
	
end
