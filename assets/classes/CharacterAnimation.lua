CharacterAnimation = Core.class(Sprite)

function CharacterAnimation:init(character)

	self.scale = character.scale
	local filename = character.sprite

	self.mc = nil -- animated sprite (MovieClip) of the character
	self.bar = nil -- health bar - lazy load, dx = 0, dy = 0},{name = only when needed
	self.dead = false
	self.name = filename -- save this for debugging
	self.scale = character.scale
	self.active = nil

	--DEBUG(character.sprite, character.dx, character.dy, character.scale)

	local texturePack = "images/"..filename..".png"
	local textureIndex = "images/"..filename..".txt"
	--INFO("Animated Character Pack:", texturePack, "Animated Character Index:", textureIndex)
	
	local pack = TexturePack.new(textureIndex, texturePack)

	local activity = {"WALK", "RUN", "JUMP", "ATTACK", "ATTACK_01", "ATTACK_02", "IDLE", "HURT", "DIE"}
	-- TODO ANIMATIONS handle single vs. double attack. Right now, order above matters.
		-- Requesting ATTACK if ATTACK not present will fall through to ATTACK_01. 
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
	
	local idleFrame = self.startFrames["IDLE"]
	for a = 1, #activity do
		local startFrame = self.startFrames[activity[a]]
		local endFrame = startFrame + 10 * slow - 1
		if activity[a] == "WALK" or activity[a] == "IDLE" or activity[a] == "RUN" then
			self.mc:setGotoAction(endFrame,startFrame) 
		elseif activity[a] == "DIE" then
			self.mc:setStopAction(endFrame)
		else
			self.mc:setGotoAction(endFrame,idleFrame) 
		end
	end
		
	self:setAnchorPoint(0.5,0.5)
	self:idle()

	self.mc:setAnchorPosition(self.mc:getWidth() / 2 + character.dx, self.mc:getHeight() / 2 + character.dy)
	self.mc:setScale(character.scale)
	self:addChild(self.mc)
	
	
end


function CharacterAnimation:setHealth(hpBar)

	DEBUG(self.name, hpBar, self.bar or "nil")

	if self.bar then
		self:removeChild(self.bar)
		self.bar = nil
	end

	if self.dead or hpBar == 0 then return end

	if not ASSERT_TRUE(hpBar >= 1 and hpBar <= 10, self.name, "bad hpBar value", hpBar or "nil") then return end

	local bars = manual.lists["bars"]
	self.bar = Bitmap.new(bars[hpBar])
	self.bar:setPosition(-50, -50)
	self:addChild(self.bar)	

end

-- FIX should the below live in character.lua? If yes, how to do SceneSprite, though.
function CharacterAnimation:faceWest()
	self.mc:setScaleX(-self.scale)
end

function CharacterAnimation:faceEast()
	self.mc:setScale(self.scale)
end

function CharacterAnimation:flip()
	self.mc:setScaleX(-self.mc:getScaleX())
end

function CharacterAnimation:scaleUp(s)
	self.mc:setScale(s * self.scale)
end

function CharacterAnimation:go(action)
	if action == nil or self.startFrames[action] == nil then return end
	self.mc:gotoAndPlay(self.startFrames[action])
end

function CharacterAnimation:idle()
	self:go("IDLE")
end

function CharacterAnimation:attack()
	--Requesting ATTACK if ATTACK not present will fall through to ATTACK_01.
	self:go("ATTACK")
end

function CharacterAnimation:attack1()
	if self.startFrames["ATTACK_01"] == self.startFrames["IDLE"] then
		self:attack()
	else
		self:go("ATTACK_01")
	end
end

function CharacterAnimation:attack2()
	if self.startFrames["ATTACK_02"] == self.startFrames["IDLE"] then
		self:attack()
	else
		self:go("ATTACK_02")
	end
end

function CharacterAnimation:walk()
	self:go("WALK")
end

function CharacterAnimation:jump()
	self:go("JUMP")
end

function CharacterAnimation:die(fadeOut)
	if self.dead then
		DEBUG("Second kill")
		return
	end
	
	self:go("DIE")
	self.dead = true
	self:setHealth(nil)

	if fadeOut then
		local animate = {}
		animate.alpha = 0
		local properties = {}
		properties.delay = 0
		properties.dispatchEvents = false
		
		local tween = GTween.new(self.mc, 5, animate, properties)
		
		tween.onComplete = function(event) 
			if self.mc then
				self:removeChild(self.mc)
				self.mc = nil
				self:removeFromParent()
			end
		end
		
	end
end