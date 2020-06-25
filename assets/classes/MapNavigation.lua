MapNavigation = Core.class(Sprite)

local function copy(e)
	return {c = e.c, r = e.r, x = e.x, y = e.y}
end

function MapNavigation:init(world)

	self.world = world
	local intercept = Pixel.new(COLOR_RED, 0, FG_X-MINX, MAXY-MINY)
	intercept:setPosition(MINX, MINY)
	self:addChild(intercept)

	self.focus = false
	self.hero = nil
	self.from = {x = 0, y = 0, c = 0, r = 0}
	self.to   = {x = 0, y = 0, c = 0, r = 0}
	self.character = {x = 0, y = 0, key = 1, id = 1}
	
	--self.path = {}
	--self.path.to = {x = 0, y = 0, c = 0, r = 0}

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
		- e containing x, y, c, r of click (x/y in tile centered world coordinates)
			-point x,y in world coordinates rounded to middle of tile
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
		
	return e, (event.x < FG_X and visibleTile)
end

function MapNavigation:updateVisualStatus()

	if self.line then 
		self.world.camera:removeChild(self.line)
		self.line = nil
	end
	self.world:clearMarkers()

	self.fromMarker:setVisible(self.hero and not self.look)
	self.toMarker:setVisible(self.focus)
	self.fromMarker:setPosition(self.from.x, self.from.y)	
	self.toMarker:setPosition(self.to.x, self.to.y)
	
	if not self.look and self.focus and self.hero then
		local key, layer, tile = self.world:getTileInfo(self.to.c, self.to.r)
		if layer == LAYER_MONSTERS then
			local d = distance(self.from, self.to)			
			if self.hero.weapons[1].reach > d or self.hero.weapons[2].reach > d then
				self.line = Shape.new()                        -- create the shape
				self.line:beginPath()                          -- begin a path
				self.line:setLineStyle(2, COLOR_WHITE, 0.5)    -- set the line width = 1
				self.line:moveTo(self.from.x, self.from.y)     -- move pen to start of line
				self.line:lineTo(self.to.x, self.to.y)   -- draw line
				self.line:endPath()                            -- end the path
				self.world.camera:addChild(self.line)          -- add the shape to the stage
			else
				self.world:shortestPath(self.from, self.to, true, false)
			end
		else
				self.world:shortestPath(self.from, self.to, true, false)
		end
	end
end

function MapNavigation:updateStatus()

	-- are we originating from a hero who still has a turn? 
	-- Check currentHero first
	self.hero = nil
	local hero = heroes[currentHero]
	if hero.turn and hero.c == self.from.c and hero.c == self.from.r then
		self.hero = hero
	else
		for _, v in ipairs(heroes) do
			--DEBUG("Finding hero with a turn", hero.name, c(hero))
			if v.active and v.turn then
				self.hero = v
				self.from.c = v.c
				self.from.r = v.r			
				self.from.x = (v.c - 0.5) * TILE_WIDTH
				self.from.y = (v.r - 0.5) * TILE_HEIGHT
				break
			end
		end
		if not self.hero then
			self.from.c = self.to.c
			self.from.r = self.to.r
			self.from.x = (self.to.c - 0.5) * TILE_WIDTH
			self.from.y = (self.to.r - 0.5) * TILE_HEIGHT
		end
	end

end

function MapNavigation:onMouseDown(event)

	if not self:hitTestPoint(event.x, event.y) then return end
	
	-- Where did we click, and is it on the map
	local e, visibleMapTouched = self:visibleMapTouched(event)
	--DEBUG("Down on", c(e), visibleMapTouched)

	if not visibleMapTouched then return end

	--find the tile that was touched
	local key, layer, tile = self.world:getTileInfo(e.c, e.r)	
	--DEBUG("Down on tile", c(e), manual:getEntry("layers", layer), key, tile.name)

	-- Setting up for tracking a new click
	self.look = activeAction == "look" -- Is the player looking, or walking/attacking
	self.focus = false
	self.hero = nil
	
	if self.look or layer == LAYER_MONSTERS or (layer == LAYER_ENVIRONMENT and not tile.blocked) then -- we consume click (else let it through to camera below)
		self.focus = true
		self.last = copy(e)
		self.from = copy(e)
		self.to = copy(e)
		self:updateStatus()
		self:updateVisualStatus()
		event:stopPropagation()
	end
	
	--DEBUG("Down done", self.focus, self.hero ~= nil, self.look, "from", c(self.from), "to", c(self.to))
end

function MapNavigation:onMouseMove(event)

	if not self.focus then return end
	
	-- Where did we click, and is it on the map
	local e, visibleMapTouched = self:visibleMapTouched(event)
	--DEBUG("Move to", c(e))

	if e.c == self.last.c and e.r == self.last.r then 
		--DEBUG("Move to same tile", c(e), c(self.to))
		event:stopPropagation()
		return
	end
	self.last = copy(e)

	if not self:hitTestPoint(event.x, event.y) or not visibleMapTouched then
		self.focus = false
	else	
		local key, layer, tile = self.world:getTileInfo(e.c, e.r)	
		--DEBUG("Move on Map", c(e), manual:getEntry("layers", layer), key, tile.name)
		
		if self.look or layer == LAYER_MONSTERS or layer == LAYER_TERRAIN or (layer == LAYER_ENVIRONMENT and not tile.blocked) then -- we consume click (else let it through to camera below)
			self.to = copy(e)
			self:updateStatus()
		elseif layer == LAYER_ENVIRONMENT then
			-- don't copy new location or update status, but don't give up focus either
		else
			self.focus = false
		end
	end

	self:updateVisualStatus()
	event:stopPropagation()

	--DEBUG("Move done", self.focus, self.hero ~= nil, self.look, "from", c(self.from), "to", c(self.to))
end

function MapNavigation:onMouseUp(event)

	if not self.focus then return end

	-- Where did we click, and is it on the map
	local e, visibleMapTouched = self:visibleMapTouched(event)
	--DEBUG("Up on", c(e))

	if not self:hitTestPoint(event.x, event.y) or not visibleMapTouched then
		-- nothing left to be done, we'll stop tracking this click below anyway
	else
		self.to = copy(e)
		self:updateStatus()

		local result = Event.new("line")
		result.from = copy(self.from)
		result.to = copy(self.to)
		DEBUG("Line", c(result.from), c(result.to))
		self:dispatchEvent(result)
		event:stopPropagation()
	end

	self.focus = false
	self:updateStatus()
	self:updateVisualStatus()
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

-- if map is on focus, stop propagation of touch events
function MapNavigation:onTouchesCancel(event)
	--DEBUG("touches cancel", event.touch.x, event.touch.y, self.focus)
	if self.focus then
		event:stopPropagation()
	end
end
