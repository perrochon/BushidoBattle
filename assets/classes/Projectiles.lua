--[[
--]]

Projectile = Core.class(Sprite)

function Projectile:init(pName, fromC, fromR, toC, toR)
--[[Logic: 	accepts a key pName for a projectile and outputs an animatation from a tilemap fromC, fromR to a tilemap toC, toR
			adds an image and onEventFrame event listener to the stage which dispatchs a "animation finished" event
	Called from rangedAttack
	Calls self.onEnterFrame, self.onRemovedFromStage
	Returns a bitmap to the stage
--]]	

	-- create a Bitmap 
	local info = manual:getEntry("projectiles", pName)	
	local p = Bitmap.new(info.image)
	p:setAnchorPoint(0.5, 0.5)
	
	--calculate the screen start and target variables
	local toX = (fromC - 0.5) * TILE_WIDTH 
	local toY = (fromR - 0.5) * TILE_HEIGHT 
	self.toX = (toC - 0.5) * TILE_WIDTH 
	self.toY = (toR - 0.5) * TILE_HEIGHT 

	--DEBUG("Projectile:", toX, toY, self.toX, self.toY, fromC, fromR, toC, toR)

	-- set initial position and speed
	self:setPosition(toX, toY)
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
	self:addChild(p)

	--DEBUG("Created " .. pName)
	
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)	
	self:addEventListener(Event.REMOVED_FROM_STAGE, self.onRemovedFromStage, self)
end

function Projectile:onEnterFrame()
--[[Logic:	update the position based on self.speedX, self.speedY and remove when target is hit
	Called from init
	Calls removeFromParent
	Changes p.x, p.y
--]]

	-- get the current position
	local x, y = self:getPosition()
	
	-- if the projectile hits the target, remove it 
	if math.abs(x - self.toX) < 20 and math.abs(y - self.toY) < 20 then 
		self:removeFromParent()		
	else
		-- set a new position
		x = x + self.speedX
		y = y + self.speedY
		self:setPosition(x, y)
	end
end

function Projectile:onRemovedFromStage(event)
--[[Logic: 	projectile is done, dispatch "animation finished" event
	Called from onEnterFrame
	Calls dispatchEvent
--]]

	self:dispatchEvent(Event.new("animation finished"))	
    self:removeEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

