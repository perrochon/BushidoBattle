--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2020 Louis Perrochon
]]

--[[
	Heroes and their attributes
--]]

Hero = Core.class(Character)
Hero.__classname= "Hero"

function Hero:init(entry, id)
	--[[Holding the player's stats
		entry = 1 for heroes. id is the slot [1..4]
	--]]
	
	--DEBUG(self:getClass())


	ASSERT_EQUAL(self.entry, 1)    -- Heroes are 1, monsters are > 1
	ASSERT_TRUE(0 < id and id < 5, "Hero id not in 1..4. Value is "..id) -- [1..4]

	-- Overwrite some Character fields/logic
	self.name = self.info.names[self.id]
	-- We also overwrite self.sprite and self.mc in loadSprite() below
	self:loadSprite()
	DEBUG(self.entry, self.id, self.name, self.sprite, self.xp, self.hp, self.see, self.alone)

	-- Additional Player fields
	self:setActive(false) 
	self.kills = 0
	self.level = 1
	self.money = 0
	self.light = manual:getEntry("light-source", "torch")
	
	self.fileName = "|D|hero"..id

	local info = manual:getEntry("monsters", self.info.sprites[self.id])
	--self.weapon1, self.weapon2 = info.weapon1, info.weapon2
	self.weapons[1] = manual:getEntry("weapons", info.weapon1)
	if info.weapon2 then 
		self.weapons[2] = manual:getEntry("weapons", info.weapon2)
	end
	self.weapon = self.weapons[1]
end

function Hero:setActive(active)
	self.active = active
	self.mc:setActive(active)
end

function Hero:loadSprite()
	local info = manual:getEntry("monsters", self.info.sprites[self.id])
	self.sprite =  info.sprite
	self.dx, self.dy = info.dx, info.dy
	--DEBUG(self.entry, self.id, self.name, self.sprite, self.dx, self.dy, self.scale)
	self.mc = CharacterAnimation.new(self)
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
	hero.mc = CharacterAnimation.new(hero)
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
