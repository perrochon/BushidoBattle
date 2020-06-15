--!NEED:test.lua

Loot = Core.class(Sprite)

function Loot:init(entry, c, r)

	self.entry = entry
	self.c, self.r = c, r 
	local dx, dy = 25 + math.random(50), 25 + math.random(50)
	self.x, self.y = (c-1) * TILE_WIDTH + dx, (r-1) * TILE_HEIGHT + dy
	self:setPosition(self.x, self.y)
	self:setAnchorPoint(0.5,0.5)

	self.info = manual:getEntry("loot", self.entry)	-- need to keep info around for subclass loading of sprite name
	self.name = self.info.name
	self.sprite = self.info.sprite
	self.value = self.info.value

	local region = manual.lists["loot"].pack:getTextureRegion(self.sprite)
	local bitmap = Bitmap.new(region)
	bitmap:setAnchorPoint(0.5,0.5)
	bitmap:setAlpha(0.5)
	self:addChild(bitmap)
	
	local animate = {}
	animate.alpha = 1
	local properties = {}
	properties.delay = 2 + math.random()
	properties.repeatCount = math.huge
	properties.reflect = true
	properties.dispatchEvents = false
	local speed = 0.5 + math.random()
 	local tween = GTween.new(bitmap, speed, animate, properties)

	--DEBUG(self.entry, self.name, self.c, self.r, self.x, self.y)
end

Loots = Core.class()

function Loots:init()
	self.list = {}
end

function Loots:add(loot)
	table.insert(self.list, loot)
end

function Loots:check(c, r)
	for k,v in pairs(self.list) do
		if c == v.c and r == v.r then
			table.remove(self.list, k)
			return v
		end
	end
	return nil
end