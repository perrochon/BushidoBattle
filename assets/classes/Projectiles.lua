--[[
--]]

Projectile = Core.class(Sprite)

function Projectile:init(pName, fromC, fromR, toC, toR)
--[[Logic: 	accepts a key pName for a projectile and outputs an animatation from a 
			tilemap fromC, fromR to a tilemap toC, toR
			adds an image and onEventFrame event listener to the stage which dispatchs a "complete" event
			Returns a bitmap
--]]	

	-- create a Bitmap 
	local info = manual:getEntry("projectiles", pName)	
	local p = Bitmap.new(info.image)
	p:setAnchorPoint(0.5, 0.5)
	
	--calculate the screen start and target variables
	local fromX = (fromC - 0.5) * TILE_WIDTH 
	local fromY = (fromR - 0.5) * TILE_HEIGHT 
	self.toX = (toC - 0.5) * TILE_WIDTH 
	self.toY = (toR - 0.5) * TILE_HEIGHT 

	--DEBUG("Projectile:", toX, toY, self.toX, self.toY, fromC, fromR, toC, toR)

	-- set initial position and speed
	self:setPosition(fromX, fromY)
	self.speedX = (toC - fromC) * info.speed
	self.speedY = (toR - fromR) * info.speed
	
	--adjust the rotation based on the heading
	local angle = 0
	if math.abs(toR - fromR) ~= 0 then
		--turn the angle to shoot in the direction of the monster
		angle = math.deg(math.atan2(toR - fromR, toC - fromC))
	else
		--or rotate 180 if it's directly left and don't rotate if directly right
		if fromC > toC then 
			angle = 180		
		else
			angle = 0		
		end
	end
	p:setRotation(angle)

	local animate = {}
	animate.x = self.toX
	animate.y = self.toY
	local properties = {}
	properties.delay = 0
	local d = distance({c = fromC, r = fromR},{c = toC, r = toR})
	properties.dispatchEvents = false

	local tween = GTween.new(self, d/6, animate, properties)
	tween.onComplete = function(event)
		self:removeFromParent()
		self:dispatchEvent(Event.new("complete"))
 end

	self:addChild(p)

	--DEBUG("Created " .. pName)
	
	--self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)	
	--self:addEventListener(Event.REMOVED_FROM_STAGE, self.onRemovedFromStage, self)
end