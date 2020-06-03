CharacterAnimation = Core.class(Sprite)

MOVE_SPEED @ 0.5

CharacterAnimation.spriteData = {
	-- Center animations on their center of body. Many die to the right. They all throw to the right...
	-- ScenePrites shows all sprites in a grid for the sole purpose of twiddling these parameters...
	{name = "Animal_01", dx = -24, dy = -3}, -- Bear
	{name = "Animal_02", dx = -24, dy = 30}, -- Eagle "run"/"jump" look more like flying. It dies high up
	{name = "Animal_03", dx = -24, dy = 1}, -- Wolf
	{name = "Archer_01", dx = -50, dy = 5}, -- Masked Archer
	{name = "Archer_02", dx = -50, dy = 5}, -- Armored Crossbow Man
	{name = "Archer_03", dx = -50, dy = 4}, -- Robin Hood Archer
	{name = "Assassin_01", dx = 0, dy = 1}, -- Grey Assassin (two glove blades)
	{name = "Assassin_02", dx = 0, dy = 0}, -- White Assassin (knife)
	{name = "Assassin_03", dx = 0, dy = 1}, -- Dark Assassin (crossbow glove)
	{name = "Barbarian_01", dx = -8, dy = 7}, -- Ponytail Barbarian
	{name = "Barbarian_02", dx = -8, dy = 7}, -- Viking Barbarian
	{name = "Barbarian_03", dx = -8, dy = 7}, -- Blonde Barbarian double sword
	{name = "Gladiator_01", dx = -1, dy = 6}, -- Mohawk Gladiator with sword
	{name = "Gladiator_03", dx = -1, dy = 7}, -- Gladiator with flail (weapon that didn't exist...)
	{name = "Ninja_01", dx = -41, dy = 0}, -- Black Ninja Sword
	{name = "Ninja_02", dx = -41, dy = 0}, -- Blue Ninja two blades
	{name = "Ninja_03", dx = -41, dy = 0}, -- White Ninja one blade
	{name = "Samurai_01", dx = 0, dy = 5}, -- Peasant with Tachi (long sword)
	{name = "Samurai_02", dx = 0, dy = 5}, -- Samurai with Daisho (2 matching swords, Katana and Wakisashi)
	{name = "Samurai_02_green", dx = 0, dy = 5}, 
	{name = "Samurai_02_blue", dx = 0, dy = 5}, 
	{name = "Samurai_03", dx = 0, dy = 5}, -- Samurai with Odachi (long sword)
	{name = "Troll_01", dx = 3, dy = 0}, -- Green Troll with Club
	{name = "Troll_02", dx = 3, dy = 0}, -- Grey Troll with Hammer
	{name = "Troll_03", dx = 3, dy = 0}, -- Brown Troll with Club
} 

function CharacterAnimation:init(spriteName)

	-- TODO FIX this can be simplified
	local textureData

	for k,v in pairs(self.spriteData) do
	  if v.name == spriteName then
		textureData = v
		break
	  end
	end

	local filename = textureData.name

	self.mc = nil -- animated sprite (MovieClip) of the character
	self.bar = nil -- health bar - lazy load, dx = 0, dy = 0},{name = only when needed
	self.dead = false
	self.name = filename -- save this for debugging
	
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

	--[[ TODO ANIMATION REMOVE
	local bg = Pixel.new(COLOR_YELLOW, 0.2, self:getWidth(), self:getHeight())
	bg:setAnchorPosition(self.mc:getWidth() / 2 + textureData.dx, self.mc:getHeight() / 2 + textureData.dy)
	self:addChild(bg)

	bg = Pixel.new(COLOR_RED, 1, 10, 10)
	bg:setAnchorPoint(0.5,0.5)
	self:addChild(bg)
	--]]
	
end

function CharacterAnimation:setHealth(hpBar)

	DEBUG("setHealth", self.name, hpBar, self.bar, ".")

	if self.bar then
		-- TODO ANIMATION FIX health bar
		self:removeChild(self.bar)
		self.bar = nil
	end

	if self.dead or hpBar < 0 or hpBar > 10 then return end
	
	DEBUG(LAYER_HP, manual:getEntry("layers", LAYER_HP))
	local texture = manual.lists[manual:getEntry("layers", LAYER_HP)].texture
	local region = TextureRegion.new(texture, hpBar*100, 0, 100, 100)
	self.bar = Bitmap.new(region)

	-- TODO ANIMATION - create on the fly, instead of getting it from a layer
	--local bars = manual.lists[manual:getEntry("layers", LAYER_HP)].pack
	--self.bar = manual:getSprite(LAYER_HP, hpBar) -- TODO FIX actual hero health
	--self.bar = bars -- TODO FIX actual hero health
	self.bar:setPosition(-50, -50)
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
	self.dead = true
	self:setHealth(nil)
	
	local animate = {}
	animate.alpha = 0
	local properties = {}
	properties.delay = 0
	properties.dispatchEvents = false
	
 	local tween = GTween.new(self.mc, 5, animate, properties)

	
	
	
	
end