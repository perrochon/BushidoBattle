--[[
This code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
(C) 2020 Louis Perrochon
]]

--[[
WorldMap and all the functions associated with it: 
changing tiles, generating the arrays, querying locations, etc..
]]

WorldMap = Core.class(Sprite)

function WorldMap:init(level, monsters) -- TODO rename self.level because of confusion with hero level

	--Create tables for map content (self.mapArrays) and for each TileMap (self.mapLayers)	
	--self.level = Level.new(currentMapFileName) -- read the file
	
	self.level = level

	self.mapArrays = {} -- a numeric key indicating what's in this place - defined in tiled maps and constants.lua
	self.mapLayers = {} -- the actual tile that is painted

	self.camera = Camera.new({maxZoom=3,friction=.95}) -- higher seems to make it "more slippery" (documentation says lower).

	-- assign TileMaps to self.mapLayers. table.insert ads at the end, so the order here matters
	-- needs to be consistent with Constants.lua, but also rendering.

	-- Terrain
	self.mapLayers[LAYER_TERRAIN], self.mapArrays[LAYER_TERRAIN] = 
		self.level:layerFromMap(LAYER_TERRAIN)
	self.camera:addChild(self.mapLayers[LAYER_TERRAIN]) 
	--self:debugMapInfo(LAYER_TERRAIN)

	-- Environment
	self.mapLayers[LAYER_ENVIRONMENT], self.mapArrays[LAYER_ENVIRONMENT] = 
		self.level:layerFromMap(LAYER_ENVIRONMENT)
	self.camera:addChild(self.mapLayers[LAYER_ENVIRONMENT]) 
	--self:debugMapInfo(LAYER_ENVIRONMENT)

	-- Monsters, we only use the array
	self.mapArrays[LAYER_MONSTERS] = self:placeCharacters(monsters)
	--self:debugMapInfo(LAYER_MONSTERS)	

	-- Light, we use array and tile map
	self.mapArrays[LAYER_LIGHT] = self:addLight()
	self.mapLayers[LAYER_LIGHT] = self:returnTileMap(LAYER_LIGHT)
	self.camera:addChild(self.mapLayers[LAYER_LIGHT]) 
	--self:debugMapInfo(LAYER_LIGHT)	

	self:addChild(self.camera)
	local x,y = self:computeCameraCenter()
	self.camera:centerPoint(self:computeCameraCenter())
	self.tweenCamera = true
	
	self:addEventListener(Event.ENTER_FRAME, function(event) 

		if not self.tweenCamera then return end -- not tweening camera
		if self.camera.isFocus then self.tweenCamera = false return end -- stop tweening on drag/scale
	
		local toX, toY = self:computeCameraCenter()		
		--local dx = (toX - self.lastCamera.x) -- TODO FIX get current camera...
		--local dy = (toY - self.lastCamera.y) 
		local dx = (toX - self.camera.anchorX) / 15
		local dy = (toY - self.camera.anchorY) / 15
		
		--DEBUG(c(toX - self.camera.anchorX,toY - self.camera.anchorY), c(dx, dy))
		
		if (-dx<>dx) > .5 or (-dy<>dy) > .5 then
			self.camera:centerPoint(self.camera.anchorX + dx, self.camera.anchorY + dy)
		else
			self.tweenCamera = false
		end
	end)
end

CURRENT_HERO_WEIGHT @ 5
function WorldMap:computeCameraCenter()
	-- Compute weighted middle of all active heroes
	
	local x = CURRENT_HERO_WEIGHT * heroes[currentHero].mc:getX()
	local y = CURRENT_HERO_WEIGHT * heroes[currentHero].mc:getY()
	local count = CURRENT_HERO_WEIGHT
	
	for k, v in ipairs(heroes) do
		if v.active then 
			x = x + v.mc:getX()
			y = y + v.mc:getY()
			count = count + 1
		end
	end

	x = x / count
	y = y / count
	
	return x, y
end

function WorldMap:index(c, r) --index of cell (c,r)
	return c + (r - 1) * LAYER_COLUMNS 
end


function WorldMap:placeCharacters(monsters)
	--[[Return an array to represent the characters tiles. 
		Returns a table of size LAYER_COLUMNS * LAYER_ROWS
	--]]

	local mArray = {}

	for r = 1, LAYER_ROWS do
		for c = 1, LAYER_COLUMNS do
			mArray[self:index(c, r)] = 0
		end
	end
	
	for _, monster in pairs(monsters.list) do
		mArray[self:index(monster.c, monster.r)] = monster.entry
		self.camera:addChild(monster.mc)
	end

	for _, hero in pairs(heroes) do
		if hero.active then
			mArray[self:index(hero.c, hero.r)] = hero.entry
			self.camera:addChild(hero.mc)
		end
	end
	
	return mArray
end

function WorldMap:newArray(value)
  local a = {}
  for r = 1, LAYER_ROWS do
    for c = 1, LAYER_COLUMNS do
      a[self:index(c, r)] = value
    end
  end
  return a
end

function WorldMap:addLight() 
	--[[Logic:  returns an array filled with light tile values with the area near the hero visible
		Returns a table of size LAYER_COLUMNS * LAYER_ROWS
	--]]
	
	local hero = heroes[currentHero] 	-- TODO HEROFIX loop through all active heroes

	--this is the array filled with darkness of unexplored tiles
	local lArray = self:newArray(LIGHT_UNEXPLORED)
	
	--this overlays the hero with a torch array
	--torch array is overkill if lightsources are symmetric. Could be computed
	local torchIndex = 0
	for r = hero.r - hero.light.radius, hero.r + hero.light.radius do
		for c = hero.c - hero.light.radius, hero.c + hero.light.radius do
			torchIndex = torchIndex + 1
			--only change the light array if on the screen
			if c > 0 and c <= LAYER_COLUMNS and r > 0 and r <= LAYER_ROWS and hero.light.array[torchIndex] ~= 0 then
				local i = self:index(c, r)
				lArray[i] = hero.light.array[torchIndex]
				--DEBUG(r, c, hero.light.array[torchIndex])
			end
		end
	end
	return lArray
end

function WorldMap:returnTileMap(layerId)
	-- Return a TileMap for a given tileset	

	local pack = manual.lists[manual:getEntry("layers", layerId)].pack
	local tilemap = TileMap.new(LAYER_COLUMNS, LAYER_ROWS, pack, TILE_WIDTH, TILE_HEIGHT)
	
	--use setTile to assign a tile based on the mapArray index
	for r = 1, LAYER_ROWS do
		for c = 1, LAYER_COLUMNS do
			local key = self.mapArrays[layerId][self:index(c, r)]
			if layerId == LAYER_LIGHT then
				--DEBUG(c, r, self:index(c, r), key )
				tilemap:setTile(c, r, key, 1)
			end
		end
	end	
	return tilemap
end

function WorldMap:getTileInfo(c, r, layer) 
	--[[Return the tile key, layer and tile information for a location on the map. 
				if no TileMap layer is specified, it returns the highest layer with a value.  
				i.e. monster #3, environment #2, or terrain #1
		Returns key, layer, tile
	--]]

	local i = self:index(c, r)

	--DEBUG(("(%d, %d) %d 1: %d 2:%d 3:%d"):format(c, r, layer and layer or -1, self.mapArrays[1][i], self.mapArrays[2][i], self.mapArrays[3][i]))
	
	if layer then
		local array = self.mapArrays[layer]
		local tile = nil
		--return the value for the given layer
		if layer > 2 then
			-- get tile information from constants
			tile = manual:getEntry(manual:getEntry("layers", layer), array[i])
		else
			tile = self.level.tiles[array[i]]
		end
		if tile ~= nil then
			--DEBUG(c, r, layer, array[i], tile.id, tile.name, tile.blocked)
		else
			--DEBUG(c, r, layer, array[i], "no tile")		
		end			
		return array[i], layer, tile
	else
		--go through remaining layers - which come from tiled
		for n = 3, 1, -1 do		
			local array = self.mapArrays[n]
			--find the first value that isn't 0
			if array[i] ~= 0 then
				if n == 3 then
					-- get tile information from constants
					local tile = manual:getEntry(manual:getEntry("layers", n), array[i])
					--DEBUG(c, r, n, tile.id, tile.name, tile.blocked)
					return array[i], n, tile			
				else
					local tile = self.level.tiles[array[i]]
					--DEBUG(c, r, n, tile.id, tile.name, tile.blocked)
					return array[i], n, tile
				end
			end
		end
		ERROR("There is no tile in the ground layer at", c, r)
		return 1,1,{id = 1, name = "no tile", blocked = true} 
	end
end

--[[ TODO LIGHTFIX Not currently used, but updating light might use it - leave in code for now
function WorldMap:changeTile(layerId, entry, x, y)
	--Change both the self.mapArrays entry and the tile in self.mapLayers
	local array = self.mapArrays[layerId]
	array[self:index(x, y)] = entry
	self.mapLayers[layerId]:setTile(x, y, entry, 1)
end
--]]

function WorldMap:clearTile(c, r, layerId)
	--Change both the self.mapArrays entry and the tile in self.mapLayers
	local array = self.mapArrays[layerId]
	array[self:index(c, r)] = 0
	self.mapLayers[layerId]:clearTile(c, r)
end

function WorldMap:moveHero(hero, dc, dr)
	--[[change the mapArrays and mapLayers location of a hero and 
		if it's the local hero, shift the TileMap and the light

		Changes hero.c, hero.r, position of the world
	--]]

	--DEBUG("Moving Hero", hero.name, hero.c, hero.r, dc, dr, "to", hero.c+dc, hero.r+dr)
	
	--if hero.id == localHero then 
	--move the torchlight TODO HEROLIGHT HEROFIX
	self:adjustLight(hero, dc, dr)
	--end

	self.tweenCamera = true
	--for purposes of moving around the map, the hero is just another monster
	local tween = self:moveMonster(hero, dc, dr)		
	return tween
end

function WorldMap:adjustLight(hero, dc, dr)
	--[[change the light array tiles as the hero moves
		Uses the hero's old position and the hero.light.radius to create darkness there, and the new position to light up
	--]]	
	
	--DEBUG(hero.name, hero.id)
		
	local lArray = self.mapArrays[LAYER_LIGHT]
	local i = 0

	--[[ -- TODO LIGHTFIX This doesn't look as good with smooth scrolling, need different solution or remove
	--set all previously lit tiles to 3
	for r = hero.r - hero.light.radius, hero.r + hero.light.radius do
		for c = hero.c - hero.light.radius, hero.c + hero.light.radius do
			--only change the light array and tile if on screen 
			if c > 0 and c <= LAYER_COLUMNS and r > 0 and r <= LAYER_ROWS then
				i = self:index(c, r)
				--only change if previously lit 
				if lArray[i] ~= LIGHT_UNEXPLORED then
					lArray[i] = LIGHT_DARK
					self.mapLayers[LAYER_LIGHT]:setTile(c, r, 3, 1)
				end
			end
		end
	end
	--]]

	local torchIndex = 0
	--overlay the torchArray tiles over the hero's new spot
	--TODO why can this not just be self:addLight (with modification)
	for r = hero.r + dr - hero.light.radius, hero.r + dr + hero.light.radius do
		for c = hero.c + dc - hero.light.radius, hero.c + dc + hero.light.radius do
			torchIndex = torchIndex + 1
			i = self:index(c, r)
			--only change the light array if on screen
			if c > 0 and c <= LAYER_COLUMNS and r > 0 and r <= LAYER_ROWS then
				--and needs to be updated
				if hero.light.array[torchIndex] ~= 0 then
					if lArray[i] > hero.light.array[torchIndex] then
						lArray[i] = hero.light.array[torchIndex]
						self.mapLayers[LAYER_LIGHT]:setTile(c, r, hero.light.array[torchIndex], 1)
					end
				end
			end
		end
	end
end

function WorldMap:moveMonster(monster, dc, dr)
	--Move monster in mapArray and tween the monster's location

	--DEBUG("Moving Monster", monster.name, monster.c, monster.r, dc, dr, "to", monster.c+dc, monster.r+dr)

	if monster.c > LAYER_COLUMNS or monster.r > LAYER_ROWS or monster.c < 1 or monster.r < 1 then
		ERROR("Monster current location out of bounds", monster.name, monster.c, monster.r, dc, dr)
		return
	elseif monster.c+dc > LAYER_COLUMNS or monster.r+dr > LAYER_ROWS or monster.c+dc < 1 or monster.r+dr < 1 then
		ERROR("Monster new location out of bounds", monster.name, monster.c, monster.r, dc, dr)
		return
	end
	
	self:removeMonster(monster)
	self:addMonster({c = monster.c+dc, r = monster.r+dr, entry = monster.entry})

	--update r and c
	local tween = monster:moveTo(monster.c + dc, monster.r + dr)
	return tween
end

function WorldMap:removeMonster(position)
	-- Remove monster from monster array
	local a = self.mapArrays[LAYER_MONSTERS]
	a[self:index(position.c, position.r)] = 0
end

function WorldMap:addMonster(monster)
	-- Place a monster into the monster array
	--get the array
	local a = self.mapArrays[LAYER_MONSTERS]
	--place the monster at it's position
	a[self:index(monster.c, monster.r)] = monster.entry
end

function WorldMap:blocked(c, r)
	--[[uses getTileInfo to determine if the tile is blocked or not
		returns true or false
	--]]
	--local i = self:index(c, r)
	--return (self.mapLayers[LAYER_MONSTERS] ~= 0) or tilemap:blocked(x,y)

	--getTileInfo returns the highest level layer key that isn't 0

	if c < 1 or c > LAYER_COLUMNS or r < 1 or r > LAYER_ROWS then
		DEBUG("x,y outside bounds", c,r)
		ERROR("Testing blocked on tile outside bound", c, r)
		return true
	end

	local key, layer, tile = self:getTileInfo(c, r)
	--DEBUG(x, y, key, layer, tile.name, tile.blocked)
	
	if layer == LAYER_MONSTERS then
		return true
	elseif layer == LAYER_ENVIRONMENT and tile.blocked then
		return true
	else
		return false
	end
end

function WorldMap:flee(monster, target)
	--[[ Return the direction (dx, dy) to move away from target. 
		 Chooses neighbouring tile furthest away from target
	--]]

	local c, r = monster.c, monster.r
	local dc, dr = 0, 0	-- the direction variables to return and the default values 0, 0
	local moves = {{-1, 0}, {0, 1}, {0, -1}, {1, 0}, {1, 1}, {-1, 1}, {1, -1}, {-1, -1} } -- the table of directions to try

	-- Sort by distance from the hero
	table.sort(moves, function (p1, p2) 
		return distance({c = c + p1[1], r = r + p1[2]},target) > distance({c = c + p2[1], r = r + p2[2]},target) 
	end) 

	-- Choose a non-blocked move
	for i, move in ipairs(moves) do
		dc, dr = move[1], move[2]
		--DEBUG(monster.id, monster.name, dc, dr, c+dc, r+dr, self:blocked(c + dc, r + dr))
		if not self:blocked(c + dc, r + dr) then		-- if not blocked then move in that direction 
			return dc, dr
		end
	end
	
	return 0, 0
end

function WorldMap:line(from, to)
	--	The classic Bresenham integer only line algorithm all Roguelikes use.
	--	Pick one tile along the direction of the line (one c for horizontal, one r for vertical)
	--  Return a table of {c, r} pairs on the line including {from.c, from.r} and {to.c, to.r}

	local line = {}							-- A line is series of c, r values. This gets returned
	local deltaC = math.abs(to.c - from.c)	-- The difference between the c's
	local deltaR = math.abs(to.r - from.r)	-- The difference between the r's
	local c = from.c			   			-- Start x off at the first point
	local r = from.r			   			-- Start y off at the first point

	--different increments of x and y are needed for each octant of LOS
	local incC1 = 0	
	local incC2 = 0
	local incR1 = 0
	local incR2 = 0

	if to.c >= from.c then			-- the x-values are increasing
		incC1, incC2 = 1, 1
	else						 	-- the x-values are decreasing
		incC1, incC2 = -1, -1
	end
	if to.r >= from.r then			-- the y-values are increasing
		incR1, incR2 = 1, 1
	else						  	-- the y-values are decreasing
		incR1, incR2 = -1, -1
	end
	
	--these variables are used to calculate the next points in the main loop
	local den = 0					-- denominator used to convert real number to integer
	local num = 0					-- numerator used to convert real number to integer
	local numAdd = 0				-- how much to add to the numerator
	local numPoints = 0	 			-- how many points (sometimes more x points than y points)
	
	if deltaC >= deltaR then	 	
	-- there is at least one x-value for every y-value
		incC1 = 0				  	-- don't change the x when numerator >= denominator
		incR2 = 0				  	-- don't change the y for every iteration
		den = deltaC	
		num = deltaC / 2
		numAdd = deltaR
		numPoints = deltaC	 		-- there are more x-values than y-values
	else						  
	-- there is at least one y-value for every x-value
		incC2 = 0				  	-- don't change the x for every iteration
		incR1 = 0				  	-- don't change the y when numerator >= denominator
		den = deltaR
		num = deltaR / 2
		numAdd = deltaC
		numPoints = deltaR		 	-- there are more y-values than x-values
	end

	--this is the main loop.  add x, y to the table called line
	for i = 0, numPoints do
		table.insert(line, {c, r})	-- add to the line table
		num = num + numAdd			-- increase the numerator by the top of the fraction
		if num >= den then		 	-- check if numerator >= denominator
			num = num - den		   	-- calculate the new numerator value
			c = c + incC1		   	-- change the x as appropriate
			r = r + incR1		   	-- change the y as appropriate
		end
		c = c + incC2			 	-- change the x as appropriate
		r = r + incR2			 	-- Change the y as appropriate
	end
	return line
end

function WorldMap:lineOfCover(from, to)
	-- Check tile.cover values until they go below COVER or we reach to
	-- Return totalCover, to.c, to.r if totalCover >= COVER (valid line of sight)
	-- Return totalCover, <coordinates of blocker> if totalCover < COVER (no line of sight)

	local totalCover = 0
	local line = self:line(from, to)

	-- remove the starting c, r
	table.remove(line, 1)
	for key, coordinates in pairs(line) do
		local c, r = coordinates[1], coordinates[2]

		-- Environment
		local key, layer, tile = self:getTileInfo(c, r, LAYER_ENVIRONMENT)
		if key ~= 0 then	
			totalCover = totalCover + tile.cover 
			--DEBUG("ENVIR", c, r, tile.cover, totalCover)
		end

		-- Light
		local key, layer, tile = self:getTileInfo(c, r, LAYER_LIGHT)	
		totalCover = totalCover + tile.cover
		--DEBUG("LIGHT", c, r, tile.cover, totalCover)

		if totalCover < COVER then 
			--DEBUG("Blocked", totalCover, c, r)
			return totalCover, c, r
		end
	end
	--DEBUG("Not blocked", totalCover, c, r)
	return totalCover, to.c, to.r
end


function WorldMap:setMarker(point, type, steps, score)
	if not self.path then
		self.path = Sprite.new()
		self.camera:addChild(self.path)
	end
	
	local types = { 
		["s"] = {color = COLOR_BLUE, alpha = 0.7, size = 50},
		["e"] = {color = COLOR_GREEN, alpha = 0.7, size = 50},
		["p"] = {color = COLOR_RED, alpha = 1, size = 20},
		["f"] = {color = COLOR_YELLOW, alpha = 1, size = 30},		
		}

	local color
	if steps then
		local marker = Pixel.new(COLOR_GREY, 1, 45,45)
		marker:setAnchorPoint(0.5,0.5)
		marker:setPosition((point.c - 0.5) * TILE_WIDTH - 25, (point.r - 0.5) * TILE_HEIGHT - 25)
		self.path:addChild(marker)
		local s = TextEdit.new(FONT_DEBUG, tostring(steps),{flags = FontBase.TLF_REF_MEDIAN |FontBase.TLF_CENTER|FontBase.TLF_NOWRAP})
		s:setTextColor(COLOR_YELLOW)
		s:setPosition((point.c - 0.5) * TILE_WIDTH - 25, (point.r - 0.5) * TILE_HEIGHT - 25)
		self.path:addChild(s)

		f = 25
		local grade = steps * f
		local r = grade><256
		local g = ((grade-256)<>0) >< 256
		local b = ((grade-512)<>0) >< 256
		color = ((r*256)+g)*256+b
		--DEBUG("Color", r, g, b, color)
	else
		color = types[type].color
	end
	local marker = Pixel.new(color, types[type].alpha, types[type].size,types[type].size)
	marker:setAnchorPoint(0.5,0.5)
	marker:setPosition((point.c - 0.5) * TILE_WIDTH, (point.r - 0.5) * TILE_HEIGHT)
	self.path:addChild(marker)
	
	if score then
		local marker = Pixel.new(COLOR_GREY, 1, 45,45)
		marker:setAnchorPoint(0.5,0.5)
		marker:setPosition((point.c - 0.5) * TILE_WIDTH - 25, (point.r - 0.5) * TILE_HEIGHT + 25)
		self.path:addChild(marker)
		local s = TextEdit.new(FONT_DEBUG, tostring(score),{flags = FontBase.TLF_REF_MEDIAN |FontBase.TLF_CENTER|FontBase.TLF_NOWRAP})
		s:setTextColor(COLOR_YELLOW)
		s:setPosition((point.c - 0.5) * TILE_WIDTH - 25, (point.r - 0.5) * TILE_HEIGHT + 25)
		self.path:addChild(s)
	end
	
end

function WorldMap:clearMarkers()
	if self.path then
		self.camera:removeChild(self.path)
		self.path= nil
	end
end

function WorldMap:shortestPath(from, to, draw, darkness)
	-- if draw then put markers on the map
	-- if darkness can route through darkness

	self:clearMarkers()
	--self:setMarker(from, "s")
	--self:setMarker(to, "e")

	queue = {}
	found = {}
	iterations = 0
	
	from.dc = 0
	from.dr = 0
	from.steps = 0 
	from.incoming = from
	--from.score = distance(from, to) / 1.41 + from.steps
	local dc,dr = from.c - to.c, from.r - to.r
	from.score = from.steps + (-dc<>dc)<>(-dr<>dr)
	table.insert(queue, from)
	found[self:index(from.c, from.r)] = from	
	--DEBUG("Starting with", c(from), c(to), c(from.incoming), #queue)

	local maxQueue = #queue
	
	local start = os.timer()
	local timeOut = 0.02 -- in seconds, 0.01 is 10ms, which is enough on windows and Pixel 3
		
	while #queue > 0 and (os.timer() - start) < timeOut do
		-- Test Peasant Mob Map to make sure peasants march. 200 seems to be enough
	
		maxQueue = #queue<>maxQueue
	
	
		-- Sort by possible shortest path. 
		table.sort(queue, function (p1, p2)
				
			--local d1 = distance(p1, to)/1.41 + p1.steps
			--local d2 = distance(p2, to)/1.41 + p2.steps
			return p1.score < p2.score 
		end) 

		current = queue[1]
		table.remove(queue, 1)
		iterations = iterations + 1
		--DEBUG("Visiting", current.c, current.r, current.dc, current.dr, current.steps, to.c, to.r, #queue)			

 		if current.c == to.c and current.r == to.r then
			-- TODO FIX Move this into the loop and test next instead of current (avoids adding nodes)
			-- DEBUG("Found Target", c(from), c(current), current.dc, current.dr)
			
			if draw then
				local walker, s = current, 0
				while walker.incoming.c ~= from.c or walker.incoming.r ~= from.r and s < 100 do
					walker = walker.incoming
					--DEBUG(s, ":", c(from), c(current), walker.c, walker.r)
					self:setMarker(walker, "f")
					s = s + 1
				end
			end
			
			--DEBUG("Found after", math.floor((os.timer() - start) * 1000000)/1000, iterations, maxQueue, c(from), c(to)) -- TODO
			return current.dc, current.dr
		end
		
		for dr = -1, 1 do
			for dc = -1 , 1 do
				if (dr ~= 0 or dc ~= 0) 
				and current.c + dc > 1 and current.c + dc < LAYER_COLUMNS 
				and current.r + dr > 1 and current.r + dr < LAYER_ROWS then

					--DEBUG("Checking", c(current.c + dc,current.r + dr))

					local penalty = 0
					if dc ~= 0 and dr ~= 0 then penalty = 0.01 end

					-- Search queue if we have that new node already
					next = nil
					for k,v in pairs(found) do
						if current.c + dc == v.c and current.r + dr == v.r then
							next = v
							--DEBUG("Found", c(v))
							break
						end	
					end

					if next == nil then 
						next = {c = current.c + dc, r = current.r + dr}
						
						local key, layer, tile = self:getTileInfo(next.c, next.r)
						local blocked = (layer == LAYER_ENVIRONMENT and tile.blocked)

						-- A monster next to source stops this path of exploration...
						if current.steps == 0 then
							blocked = blocked or (layer == LAYER_MONSTERS)
						end
						
						if not darkness then
							key, layer, tile = self:getTileInfo(next.c, next.r, LAYER_LIGHT)
							blocked = blocked or tile.cover < -5
						end

						next.score = math.huge
						next.steps = math.huge
						
						if blocked then 
							--DEBUG("Blocked", c(next))
							next = nil 
						else
							table.insert(queue, next)
							found[self:index(next.c, next.r)] = next
							--DEBUG("Adding", c(next))
						end												
					end
						
					if next then 
						
						if current.steps + 1 + penalty < next.steps then
							next.steps = current.steps + 1 + penalty
							local cc,rr = next.c - to.c, next.r - to.r
							next.score = next.steps + (-cc<>cc)<>(-rr<>rr) 
							next.incoming = current
		
							if current.steps > 0  then -- carry forward on original direction
								next.dc = current.dc
								next.dr = current.dr
							else -- first set of nodes, set initial direction
								next.dc = dc
								next.dr = dr					
							end
						
							--self:setMarker(next, "f", next.steps, next.score)

							--DEBUG("Updating", c(next), next.dc, next.dr, next.steps, next.score, c(next.incoming))
						end
					end
				end
			end
		end
	end

	-- naive
	local elapsed = math.floor((os.timer() - start) * 1000000)/1000
	--DEBUG("Giving up BFS after", elapsed, iterations, #queue, maxQueue, c(from), c(to)) -- TODO
	ASSERT_FALSE(elapsed > timeOut * 1000, "BFS timed out")
	local dc = (to.c - from.c)>0 and 1 or (to.c - from.c)<0 and -1 or 0
	local dr = (to.r - from.r)>0 and 1 or (to.r - from.r)<0 and -1 or 0
		
	if not self:blocked(from.c + dc, from.r + dr) then
		return dc, dr
	else
		return 0, 0
	end
end

-- Debug functions


function WorldMap:debugMapInfo(id)
	DEBUG(("World: %d layers  and %d arrays"):format(#self.mapLayers, #self.mapArrays))
	if self.mapLayers[id] then
		DEBUG(("Layer[%d] %s %dx%d at %d %d %d"):format(id, manual:getEntry("layers", id), id, self.mapLayers[id]:getWidth(), 
			self.mapLayers[id]:getHeight(), 
			self.mapLayers[id]:getPosition()))
	end
	
	a = self.mapArrays[id]
	DEBUG(("Array[%d] %s  %d"):format(id, manual:getEntry("layers", id), #a)) 
	for r = 1, LAYER_ROWS do
		local s = ""
		for c = 1, LAYER_COLUMNS do
			local i = self:index(c, r)
			s = s .. a[i] .. " "
		end
		DEBUG(s)
	end

end
