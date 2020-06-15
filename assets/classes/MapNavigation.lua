MapNavigation = Core.class(Sprite)

function MapNavigation:init(world)

	self.world = world
	local intercept = Pixel.new(COLOR_RED, 0, FG_X-MINX, MAXY-MINY)
	intercept:setPosition(MINX, MINY)
	self:addChild(intercept)

	self.focus = false
	self.from = {x = 0, y = 0, c = 0, r = 0}
	self.to   = {x = 0, y = 0, c = 0, r = 0}
	self.character = {x = 0, y = 0, key = 1, id = 1}
	
	self.path = {}
	self.path.to = {x = 0, y = 0, c = 0, r = 0}

	self.fromMarker = Bitmap.new(Texture.new("images/glow120x120.png"))
	self.fromMarker:setAnchorPoint(0.5,0.5)
	self.fromMarker:setPosition(self.from.x, self.from.y)
	self.fromMarker:setVisible(false)
	self.world.camera:addChild(self.fromMarker)

	self.toMarker = Bitmap.new(Texture.new("images/redglow.png"))
	self.toMarker:setAnchorPoint(0.5,0.5)
	self.toMarker:setScale(0.2)
	self.toMarker:setPosition(self.to.x,self.to.y)
	self.toMarker:setVisible(false)
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
	e.c = math.ceil(e.x / TILE_WIDTH)
	e.r = math.ceil(e.y / TILE_HEIGHT)
	e.x = (e.c-0.5) * TILE_WIDTH
	e.y = (e.r-0.5) * TILE_HEIGHT
	--DEBUG("checking", event.x, event.y, " - ", e.x, e.y, " - ", c, r, self.focus)

	local visibleTile = false
	if e.c > 0 and e.c <= LAYER_COLUMNS and e.r > 0 and e.r <= LAYER_ROWS then
		local key, layer, tile = self.world:getTileInfo(e.c, e.r, LAYER_LIGHT)
		--DEBUG("tile is", key, layer, tile.name)
		if key < 4 then
			visibleTile = true
		end
	end
	
	-- FIXME HEROFIX VISIBILITY ignoring visibility for now
	visibleTile = true
	
	return e, e.c, e.r, (event.x < FG_X and visibleTile)
end

function MapNavigation:updateVisualStatus()

	--local dx = (self.hero.key == 1) and TILE_WIDTH or 0 -- TODO FIX offset target for touch users
	--local dy = (self.hero.key == 1) and TILE_HEIGHT or 0
	
	dx, dy = 0,0 -- offset toMarker a bit so it's not under the finger

	self.fromMarker:setVisible(self.focus)
	self.toMarker:setVisible(self.focus)

	if self.line then 
		self.world.camera:removeChild(self.line)
		self.line = nil
	end

	
	if self.focus then
	
		local key, layer, tile = self.world:getTileInfo(self.to.c, self.to.r)

		if self.path.to.c ~= self.to.c or self.path.to.r ~= self.to.r  then
			--DEBUG("looking at new location", self.to.c, self.to.r)
			self.path.to.c = self.to.c
			self.path.to.r = self.to.r  
			if layer == 1 then
				self.world:shortestPath({c = self.from.c, r = self.from.r}, {c = self.to.c, r = self.to.r})
			end
		end

		self.fromMarker:setPosition(self.from.x, self.from.y)
		self.toMarker:setPosition(self.to.x - dx, self.to.y - dy)

		self.line = Shape.new()                        -- create the shape
		self.line:beginPath()                          -- begin a path
		self.line:setLineStyle(2, COLOR_WHITE, 0.5)    -- set the line width = 1
		self.line:moveTo(self.from.x, self.from.y)     -- move pen to start of line
		self.line:lineTo(self.to.x-dx, self.to.y-dy)   -- draw line
		self.line:endPath()                            -- end the path
		self.world.camera:addChild(self.line)          -- add the shape to the stage
	end
	

	
end

function MapNavigation:onMouseDown(event)

	if not self:hitTestPoint(event.x, event.y) then
		return
	end

	-- Where did we click, and is it on the map
	local e, c, r, visibleMapTouched = self:visibleMapTouched(event)
	--DEBUG("Down on", c ,r , e.x, e.y)

	if visibleMapTouched then
		--find the tile that was touched
		local key, layer, tile = self.world:getTileInfo(c, r)	
		--DEBUG("Down on Map", c, r, e.x, e.y, manual:getEntry("layers", layer), key, tile.name)

		
		if layer == LAYER_MONSTERS or layer == LAYER_ENVIRONMENT then
			self.character.key = key
			self.to = e			
			self.from = e

			if key == 1 then
				for id, hero in ipairs(heroes) do
					--DEBUG("Comparing with hero", hero.name, hero.c, hero.r, c, r)
					if hero.active and hero.c == c and hero.r == r then
						self.character.id = id
					end
				end
				--self.from.c = heroes[self.character.index].c
				--self.from.r = heroes[self.character.index].r			
				--self.from.x = (heroes[self.character.index].c-0.5) * TILE_WIDTH
				--self.from.y = (heroes[self.character.index].r-0.5) * TILE_HEIGHT
			end

			self.focus = true

			--DEBUG(self.focus, "from", self.from.x, self.from.y, "to", self.to.x, self.to.y)
			self:updateVisualStatus()
			event:stopPropagation()
		end
	end
end

function MapNavigation:onMouseMove(event)

	if self.focus then
		-- Where did we click, and is it on the map
		local e, c, r, visibleMapTouched = self:visibleMapTouched(event)

		--DEBUG("on Map", c, r, e.x, e.y)

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
		local e, c, r, visibleMapTouched = self:visibleMapTouched(event)
		--DEBUG("Up on", c ,r , e.x, e.y)

		if self:hitTestPoint(event.x, event.y) and visibleMapTouched then	
			local result = Event.new("line")
			result.from = self.from
			result.to = e
			DEBUG("Line from", result.from.c, result.from.r, result.to.c, result.to.r)
			self:dispatchEvent(result)	-- dispatch line drawn event
		end

		self.focus = false
		self:updateVisualStatus()
		event:stopPropagation()

	end
end

-- if map is on focus, stop propagation of touch events
function MapNavigation:onTouchesBegin(event)
	--DEBUG("ScreenPlay touches begin", event.touch.x, event.touch.y, self.focus)
	if self.focus then
		event:stopPropagation()
	end
end

-- if map is on focus, stop propagation of touch events
function MapNavigation:onTouchesMove(event)
	--DEBUG("touches move", event.touch.x, event.touch.y, self.focus)
	if self.focus then
		event:stopPropagation()
	end
end

-- if map is on focus, stop propagation of touch events
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
