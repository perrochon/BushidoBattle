CharacterAnimation = Core.class(Sprite)

MOVE_SPEED @ 0.5

function CharacterAnimation:init(filename)

	self.mc = nil -- animated sprite (MovieClip) of the character
	self.bar = nil -- health bar - lazy load, only when needed

	local texturePack = "images/"..filename..".png"
	local textureIndex = "images/"..filename..".txt"
	INFO("Animated Character Pack:", texturePack, "Animated Character Index:", textureIndex)
	
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
	
	--if not (filename == "Troll_03") then return nil end
	
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
	
	self.mc:setScale(1.3)
	self.mc:setAnchorPosition(15,15)
	self:addChild(self.mc)
	
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