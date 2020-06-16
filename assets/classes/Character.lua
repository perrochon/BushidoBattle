--!NEED:test.lua

Character = Core.class()

function Character:init(entry, id)

	self.entry = entry  -- position/key in manual, and the world's monster array. 1 is a hero, the rest are monsters
	self.id = id
	self.mc = nil -- MovieClip
	self.c, self.r = 1, 1 -- temporary coordinates when first created.

	self.info = manual:getEntry("monsters", self.entry)	-- need to keep info around for subclass loading of sprite name
	self.name = self.info.name
	self.xp = self.info.xp 
	self.dx = self.info.dx
	self.dy = self.info.dy

	-- attack / defense stats
	self.hp = self.info.hp
	self.maxHP = self.hp
	self.HPbar = 0
	self.defense = self.info.defense
	self.resist = self.info.resist
	
	self.weapons = {}
	self.weapons[1] = manual:getEntry("weapons", self.info.weapon1)
	if self.info.weapon2 then 
		self.weapons[2] = manual:getEntry("weapons", self.info.weapon2)
	end
	self.weapon = self.weapons[1]	

	-- used by monster AI
	self.bloodiedHP = self.info.bloodied and self.info.bloodied or math.ceil(self.hp / 2)
	self.tactics = self.info.tactics
	self.see = self.info.see
	self.alone = self.info.alone
	
	self.drop = self.info.drop
	
	-- TODO REFACTOR Call loadSprite here, and pick the one from the subclass, instead of calling in subclass init()
	--self.sprite = self.info.sprite -- Heroes have a list of sprites, so differ from monsters
	self.dx = self.info.dx
	self.dy = self.info.dy
	self.scale = self.info.scale
	
	--DEBUG(self.entry, self.id, self.name, self.sprite, self.xp, self.hp, self.see, self.alone)
	
end

function Character:loadSprite()
	self.sprite = self.info.sprite
	--DEBUG(self.entry, self.id, self.name, self.sprite, self.dx, self.dy, self.scale)
	self.mc = CharacterAnimation.new(self)
	--self.mc.mc:gotoAndPlay(1)
	self.mc:setPosition((self.c - 1) * TILE_WIDTH, (self.r - 1) * TILE_HEIGHT)
end

function Character:setHealth(health)
	self.hp = health
	self.HPbar = 10 - math.floor((self.hp / self.maxHP) * 10)
	self.mc:setHealth(self.HPbar)
end



function Character:setPosition(c, r)
	self.c = c
	self.r = r
	self.mc:setPosition(c * TILE_WIDTH - TILE_WIDTH / 2, r * TILE_HEIGHT - TILE_HEIGHT / 2)
end

function Character:moveTo(c, r)

	--DEBUG("Moving Character", self.name, self.c, self.r, "to", c, r)

	if self.c > c then
		self.mc:faceWest()
	elseif self.c < c then
		self.mc:faceEast()
	end

	self.c = c
	self.r = r

	local animate = {}
	animate.x = self.c * TILE_WIDTH - TILE_WIDTH / 2
	animate.y = self.r * TILE_HEIGHT - TILE_HEIGHT / 2
	local properties = {}
	properties.delay = 0
	properties.dispatchEvents = false
	
	self.mc:walk()
	

 	local tween = GTween.new(self.mc, MOVE_SPEED, animate, properties)
	tween.onComplete = function(event) self.mc:idle() end
	
	return tween
end
