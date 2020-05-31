CharacterAnimation = Core.class(Sprite)

MOVE_SPEED @ 0.5

CharacterAnimation.textureData = {
	-- Center animations on their center of body. Many die to the right. They all throw to the right...
	-- ScenePrites shows all sprites in a grid for the sole purpose of twiddling these parameters...
	{name = "Animal_01", dx = -20, dy = 0},
	{name = "Animal_02", dx = -20, dy = 20}, -- Eagle "run"/"jump" look more like flying. It dies high up
	{name = "Animal_03", dx = -20, dy = 0},
	{name = "Archer_01", dx = -50, dy = 0},
	--[[
	{name = "Archer_02", dx = 0, dy = 0},
	{name = "Archer_03", dx = 0, dy = 0},
	{name = "Assassin_01", dx = 0, dy = 0},
	{name = "Assassin_02", dx = 0, dy = 0},
	{name = "Assassin_03", dx = 0, dy = 0},
	{name = "Barbarian_01", dx = 0, dy = 0},
	{name = "Barbarian_02", dx = 0, dy = 0},
	{name = "Barbarian_03", dx = 0, dy = 0},
	{name = "Gladiator_01", dx = 0, dy = 0},
	{name = "Gladiator_03", dx = 0, dy = 0},
	{name = "Ninja_01", dx = 0, dy = 0},
	{name = "Ninja_02", dx = 0, dy = 0},
	{name = "Ninja_03", dx = 0, dy = 0},
	{name = "Samurai_01", dx = 0, dy = 0},
	{name = "Samurai_02", dx = 0, dy = 0},
	{name = "Samurai_03", dx = 0, dy = 0},
	{name = "Troll_01", dx = 0, dy = 0},
	{name = "Troll_02", dx = 0, dy = 0},
	{name = "Troll_03", dx = 0, dy = 0},
	--]]
	} 

function CharacterAnimation:init(textureData)

	local filename = textureData.name

	self.mc = nil -- animated sprite (MovieClip) of the character
	self.bar = nil -- health bar - lazy load, dx = 0, dy = 0},{name = only when needed
	
	--DEBUG(textureData.name, textureData.dx, textureData.dy)

	local texturePack = "images/"..filename..".png"
	local textureIndex = "images/"..filename..".txt"
	--INFO("Animated Character Pack:", texturePack, "Animated Character Index:", textureIndex)
	
	local pack = TexturePack.new(textureIndex, texturePack)

	local activity = {"WALK", "RUN", "JUMP", "ATTACK", "ATTACK_01", "ATTACK_02", "IDLE", "HURT", "DIE"}
	-- TODO ANIMATIONS handle single vs. double attack. Right now, order above matters.
		-- Requesting ATTACK if ATTACK not pressent will fall through to ATTACK_01. 
		-- Requesting ATTACK_01 or ATTACK_02 if not present will fall through to IDLE 
	
	local timeline = {}
	local c = 1
	local slow = 6
	self.slow = slow
	
	self.startFrames = {}
		
	for a = 1, #activity do
		self.startFrames[activity[a]] = c
		for s = 0, 9 do
			local texture = string.format("%s__%s_%03d.png", filename, activity[a], s)
			--DEBUG("Looking for texture:", texture)
			local region = pack:getTextureRegion(texture)
			if not(region == nil) then
				--DEBUG(filename, "found")
				local bitmap = Bitmap.new(region)
				table.insert(timeline, {c, c+slow-1, bitmap})
				c = c + slow
			else
				--DEBUG(texture, "not found")
			end
		end
	end
	
	self.mc = MovieClip.new(timeline)
	self.mc:setGotoAction(10*slow-1, 1)
	for a = 20*slow-1, c, 10*slow do
		--self.mc:setGotoAction(a, 1)
		self.mc:setStopAction(a)
	end
	

	self:setAnchorPoint(0.5,0.5)

	self:addChild(self.mc)
	self.mc:setAnchorPosition(self.mc:getWidth() / 2 + textureData.dx, self.mc:getHeight() / 2 + textureData.dy)

	local bg = Pixel.new(COLOR_YELLOW, 0.2, self:getWidth(), self:getHeight())
	bg:setAnchorPoint(0.5,0.5)
	self:addChild(bg)

	bg = Pixel.new(COLOR_GREEN, 0.2, 100, 100)
	bg:setAnchorPoint(0.5,0.5)
	self:addChild(bg)
	
end

function CharacterAnimation:setHealth(hpBar)

	DEBUG("setHealth", hpBar)

	if self.bar then
		self:removeChild(self.bar)
	end
	self.bar = manual:getSprite(LAYER_HP, hpBar) -- TODO FIX actual hero health
	self:addChild(self.bar)	
end

function CharacterAnimation:go(action)
	if action == nil or self.startFrames[action] == nil then return end
	self.mc:gotoAndPlay(self.startFrames[action])
end

function CharacterAnimation:walk()
	self:go("WALK")
end

function CharacterAnimation:die()
	self:go("DIE")
end