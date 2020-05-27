CharacterAnimation = Core.class(Sprite)

function CharacterAnimation:init()

	local texturePack = "images/Ninja_02.png"
	local textureIndex = "images/Ninja_02.txt"
	INFO("Animated Character Pack:", texturePack, "Animated Character Index:", textureIndex)
	
	local pack = TexturePack.new(textureIndex, texturePack)

	local character = "Ninja_02__"
	local activity = {"IDLE_", "WALK_", "RUN_", "JUMP_", "ATTACK_01_", "ATTACK_02_", "HURT_", "DIE_"}
	
	local timeline = {}
	local c = 0
	for a = 1, 8 do
		for s = 0, 9 do
			local filename = string.format("%s%s%03d.png", character, activity[a], s)
			--DEBUG(filename)
			local bitmap = Bitmap.new(pack:getTextureRegion(filename))
			table.insert(timeline, {c, c+2, bitmap})
			c = c + 3
		end
		for s = 0, 9 do
			local filename = string.format("%s%s%03d.png", character, activity[1], s)
			--DEBUG(filename)
			local bitmap = Bitmap.new(pack:getTextureRegion(filename))
			table.insert(timeline, {c, c+2, bitmap})
			c = c + 3
		end
		for s = 0, 9 do
			local filename = string.format("%s%s%03d.png", character, activity[1], s)
			--DEBUG(filename)
			local bitmap = Bitmap.new(pack:getTextureRegion(filename))
			table.insert(timeline, {c, c+2, bitmap})
			c = c + 3
		end
	end
	
	local mc = MovieClip.new(timeline)
	mc:setGotoAction(c-1, 1)
	
	self:addChild(mc)
	
end
