CharacterAnimation = Core.class(Sprite)

function CharacterAnimation:init(filename)

	local texturePack = "images/"..filename..".png"
	local textureIndex = "images/"..filename..".txt"
	INFO("Animated Character Pack:", texturePack, "Animated Character Index:", textureIndex)
	
	local pack = TexturePack.new(textureIndex, texturePack)

	local character = filename.."__"
	local activity = {"IDLE", "WALK", "RUN", "JUMP", "ATTACK_01", "ATTACK_02", "HURT", "DIE"}
	
	local timeline = {}
	local c = 1
	local slow = 6
	self.slow = slow
	
	self.startFrames = {}
	
	for a = 1, 8 do
		self.startFrames[activity[a]] = c
		for s = 0, 9 do
			local filename = string.format("%s%s_%03d.png", character, activity[a], s)
			--DEBUG(filename)
			local bitmap = Bitmap.new(pack:getTextureRegion(filename))
			table.insert(timeline, {c, c+slow-1, bitmap})
			c = c + slow
		end
	end
	
	self.mc = MovieClip.new(timeline)
	for a = 10*slow-1, c, 10*slow do
		--self.mc:setGotoAction(a, 1)
		self.mc:setStopAction(a)
	end
	
	self:addChild(self.mc)
	
end

function CharacterAnimation:go(action)
	if action == nil or self.startFrames[action] == nil then return end
	self.mc:gotoAndPlay(self.startFrames[action])
end

function CharacterAnimation:walk()
	self:go("WALK")
end