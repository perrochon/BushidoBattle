MapNavigation = Core.class(Sprite)

function MapNavigation:init(world, heroes)

	self.world = world
	self.heroes = heroes
	local intercept = Pixel.new(COLOR_RED, 0.1, FG_X-MINX, APP_HEIGHT-MINY)
	intercept:setPosition(MINX, MINY)
	self:addChild(intercept)

	self.focus = false
	self.from = {x=1, y=10}
	self.to = {x=1, y=11}
	self.hero = { x = 0, y = 0, key = 1, index = 1}

	self.fromMarker = Bitmap.new(Texture.new("images/glow120x120.png"))
	self.fromMarker:setAnchorPoint(0.5,0.5)
	self.fromMarker:setPosition(self.from.x,self.from.y)
	self.world.camera:addChild(self.fromMarker)

	self.toMarker = Bitmap.new(Texture.new("images/redglow.png"))
	self.toMarker:setAnchorPoint(0.5,0.5)
	self.toMarker:setScale(0.2)
	self.toMarker:setPosition(self.to.x,self.to.y)
	self.world.camera:addChild(self.toMarker)

	self:addEventListener(Event.MOUSE_DOWN, self.onMouseDown, self)
	self:addEventListener(Event.MOUSE_MOVE, self.onMouseMove, self)
	self:addEventListener(Event.MOUSE_UP, self.onMouseUp, self)
	
	self:addEventListener(Event.TOUCHES_BEGIN, self.onTouchesBegin, self)
	self:addEventListener(Event.TOUCHES_MOVE, self.onTouchesMove, self)
	self:addEventListener(Event.TOUCHES_END, self.onTouchesEnd, self)
	self:addEventListener(Event.TOUCHES_CANCEL, self.onTouchesCancel, self)
	
end

function MapNavigation:visibleMapTouched(event)
	--[[ returns
		- point x,y in world coordinates rounded to middle of tile
		- column, row index of tile
		- whether the visible map was touched (i.e. left area of screen AND not outside bounds) 
	--]]
	local e = self.world.camera:translateEvent(event)
	local x = math.ceil(e.x / TILE_WIDTH)
	local y = math.ceil(e.y / TILE_HEIGHT)
	e.x = (x-0.5) * TILE_WIDTH
	e.y = (y-0.5) * TILE_HEIGHT
	DEBUG("mouse down", event.x, event.y, " - ", e.x, e.y, " - ", x, y, self.focus)
	return e, x, y, (event.x < FG_X and x > 0 and x <= LAYER_COLUMNS and y > 0 and y <= LAYER_ROWS)
end

function MapNavigation:updateVisualStatus()

	--local dx = (self.hero.key == 1) and TILE_WIDTH or 0
	--local dy = (self.hero.key == 1) and TILE_HEIGHT or 0
	
	dx, dy = 0,0

	self.fromMarker:setVisible(self.focus)
	self.toMarker:setVisible(self.focus)

	self.fromMarker:setPosition(self.from.x,self.from.y)
	self.toMarker:setPosition(self.to.x-dx,self.to.y-dy)

	if self.line then 
		self.world.camera:removeChild(self.line)
		self.line = nil
	end
	
	if self.focus then
		self.line = Shape.new() -- create the shape
		self.line:beginPath()         -- begin a path
		self.line:setLineStyle(2, COLOR_WHITE, 0.5)     -- set the line width = 1
		self.line:moveTo(self.from.x,self.from.y)     -- move pen to start of line
		self.line:lineTo(self.to.x-dx,self.to.y-dy)     -- draw line
		self.line:endPath()           -- end the path
		self.world.camera:addChild(self.line)     -- add the shape to the stage
	end

end

function MapNavigation:onMouseDown(event)

	if not self:hitTestPoint(event.x, event.y) then
		return
	end

	-- Where did we click, and is it on the map
	local e, x, y, visibleMapTouched = self:visibleMapTouched(event)

	if visibleMapTouched then
		--find the tile that was touched
		local key, layer, tile = self.world:getTileInfo(x, y)	
		DEBUG("    on Map", x, y, key, manual:getEntry("layers", layer))

		if self.hero.index then
		end
		
		if layer == LAYER_MONSTERS then
			self.hero.key = key
			self.to.x = e.x
			self.to.y = e.y

			if key == 1 then
				for key, value in ipairs(self.heroes) do
					DEBUG("Looking for hero", key, value.x, value.y)
					if value.x == x and value.y == y then
						self.hero.index = key
					end
				end
			end
			self.from.x = (self.heroes[self.hero.index].x-0.5) * TILE_WIDTH
			self.from.y = (self.heroes[self.hero.index].y-0.5) * TILE_HEIGHT
			DEBUG("from now is", self.from.x, self.from.y)
			
			self.focus = true
			self:updateVisualStatus()
			event:stopPropagation()
		end
	end
end

function MapNavigation:onMouseMove(event)

	if self.focus then
		-- Where did we click, and is it on the map
		local e, x, y, visibleMapTouched = self:visibleMapTouched(event)

		if not self:hitTestPoint(event.x, event.y) or not visibleMapTouched then	
			self.focus = false
		end
		self.to = e
		self:updateVisualStatus()
		event:stopPropagation()
	end
end

function MapNavigation:onMouseUp(event)

	if self.focus then
		-- Where did we click, and is it on the map
		local e, x, y, visibleMapTouched = self:visibleMapTouched(event)

		if self:hitTestPoint(event.x, event.y) and visibleMapTouched then	
			local result = Event.new("line")
			result.fromX = math.ceil(self.from.x / TILE_WIDTH)
			result.fromY = math.ceil(self.from.y / TILE_HEIGHT)
			result.toX = x
			result.toY = y
			DEBUG("Line from", result.fromX, result.fromY, result.toX, result.toY)
			self:dispatchEvent(result)	-- dispatch line drawn event
		end

		self.focus = false
		self:updateVisualStatus()
		event:stopPropagation()

	end
end

-- if button is on focus, stop propagation of touch events
function MapNavigation:onTouchesBegin(event)
	--DEBUG("ScreenPlay touches begin", event.touch.x, event.touch.y, self.focus)
	if self.focus then
		event:stopPropagation()
	end
end

-- if button is on focus, stop propagation of touch events
function MapNavigation:onTouchesMove(event)
	--DEBUG("touches move", event.touch.x, event.touch.y, self.focus)
	if self.focus then
		event:stopPropagation()
	end
end

-- if button is on focus, stop propagation of touch events
function MapNavigation:onTouchesEnd(event)
	--DEBUG("touches end", event.touch.x, event.touch.y, self.focus)
	if self.focus then
		event:stopPropagation()
	end
end

-- if touches are cancelled, reset the state of the button
function MapNavigation:onTouchesCancel(event)
	--DEBUG("touches cancel", event.touch.x, event.touch.y, self.focus)
	if self.focus then
		event:stopPropagation()
	end
end
