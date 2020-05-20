MapNavigation = Core.class(Sprite)

function MapNavigation:init(world)

	self.world = world
	local intercept = Pixel.new(COLOR_RED, 0.1, FG_X-MINX, APP_HEIGHT-MINY)
	intercept:setPosition(MINX, MINY)
	self:addChild(intercept)

	self.focus = false
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
	if self.line then 
		self.world.camera:removeChild(self.line)
		self.line = nil
	end
	if self.to then
		self.world.camera:removeChild(self.to)
		self.to = nil
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
		
		if layer == LAYER_MONSTERS and key == 1 then

			self.focus = true
			self.startX = e.x
			self.startY = e.y
			self.from = Pixel.new(COLOR_BLUE, 0.5, 50, 50)
			self.from:setAnchorPoint(0.5,0.5)
			self.from:setPosition(self.startX,self.startY)
			self.world.camera:addChild(self.from)
			self.to = Pixel.new(COLOR_RED, 0.8, 50, 50)
			self.to:setAnchorPoint(0.5,0.5)
			self.to:setPosition(self.startX-TILE_WIDTH,self.startY-TILE_HEIGHT)
			self.world.camera:addChild(self.to)
			event:stopPropagation()
		end
	end
end

function MapNavigation:onMouseMove(event)

	if self.focus then

		-- Where did we click, and is it on the map
		local e, x, y, visibleMapTouched = self:visibleMapTouched(event)

		self:updateVisualStatus()
		if not self:hitTestPoint(event.x, event.y) or not visibleMapTouched then	
			self.focus = false
			self.world.camera:removeChild(self.from)
		if self.to then
			self.world.camera:removeChild(self.to)
			self.to = nil
		end
	else	
			self.to = Pixel.new(COLOR_RED, 0.8, 50, 50)
			self.to:setAnchorPoint(0.5,0.5)
			self.to:setPosition(e.x,e.y)
			self.world.camera:addChild(self.to)
			self.line = Shape.new() -- create the shape
			self.line:beginPath()         -- begin a path
			self.line:setLineStyle(2, COLOR_RED, 0.5)     -- set the line width = 1
			self.line:moveTo(self.startX,self.startY)     -- move pen to start of line
			self.line:lineTo(e.x,e.y)     -- draw line
			self.line:endPath()           -- end the path
			self.world.camera:addChild(self.line)     -- add the shape to the stage
		end
		event:stopPropagation()
	end
end

function MapNavigation:onMouseUp(event)

	if self.focus then
		-- Where did we click, and is it on the map
		local e, x, y, visibleMapTouched = self:visibleMapTouched(event)

		self.focus = false
		self.world.camera:removeChild(self.from)
		self:updateVisualStatus()
		do
			local event = Event.new("line")
			event.fromX = math.ceil(self.startX / TILE_WIDTH)
			event.fromY = math.ceil(self.startY / TILE_HEIGHT)
			event.toX = x
			event.toY = y
			DEBUG("Line from", event.fromX, event.fromY, event.toX, event.toY)
			self:dispatchEvent(event)	-- dispatch line drawn event
		end
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
